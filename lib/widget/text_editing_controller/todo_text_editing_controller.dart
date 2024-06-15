import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Todo用のTextEditingController。
class TodoTextEditingController extends TextEditingController {
  TodoTextEditingController({String? text}) : super(text: text);
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    // 編集中のテキストの範囲が範囲外の場合は、通常のTextSpanを返す
    if (!composingRegionOutOfRange) {
      return super.buildTextSpan(
          context: context, style: style, withComposing: withComposing);
    }

    // 「@10min」のような箇所だけを青色にしたTextSpanに変換する
    final spans = <TextSpan>[];
    value.text.splitMapJoin(
      RegExp(r'@(\d+)min'),
      onMatch: (m) {
        spans.add(
          TextSpan(
            text: m.group(0),
            style: style?.copyWith(color: Colors.blue),
          ),
        );
        return m[0]!;
      },
      onNonMatch: (n) {
        spans.add(TextSpan(text: n, style: style));
        return n;
      },
    );
    return TextSpan(children: spans, style: style);
  }
}

TodoTextEditingController useTodoTextEditingController({String? text}) {
  return use(_TodoTextEditingControllerHook(text: text));
}

class _TodoTextEditingControllerHook extends Hook<TodoTextEditingController> {
  final String? text;

  const _TodoTextEditingControllerHook({this.text});

  @override
  _MarkdownTextEditingControllerHookState createState() =>
      _MarkdownTextEditingControllerHookState();
}

class _MarkdownTextEditingControllerHookState extends HookState<
    TodoTextEditingController, _TodoTextEditingControllerHook> {
  late final controller = TodoTextEditingController();

  @override
  void initHook() {
    if (hook.text != null) {
      controller.text = hook.text!;
    }
  }

  @override
  TodoTextEditingController build(BuildContext context) => controller;

  @override
  void dispose() {
    controller.dispose();
  }
}
