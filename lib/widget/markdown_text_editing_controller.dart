import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/widget/markdown_text_span.dart';

class MarkdownTextEditingController extends TextEditingController {
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context, TextStyle? style, bool? withComposing}) {
    return MarkdownTextSpan(text: text, style: style);
  }
}

MarkdownTextEditingController useMarkdownTextEditingController({String? text}) {
  return use(_MarkdownTextEditingControllerHook(text: text));
}

class _MarkdownTextEditingControllerHook
    extends Hook<MarkdownTextEditingController> {
  final String? text;

  const _MarkdownTextEditingControllerHook({this.text});

  @override
  _MarkdownTextEditingControllerHookState createState() =>
      _MarkdownTextEditingControllerHookState();
}

class _MarkdownTextEditingControllerHookState extends HookState<
    MarkdownTextEditingController, _MarkdownTextEditingControllerHook> {
  late final controller = MarkdownTextEditingController();

  @override
  void initHook() {
    if (hook.text != null) {
      controller.text = hook.text!;
    }
  }

  @override
  MarkdownTextEditingController build(BuildContext context) => controller;

  @override
  void dispose() {
    controller.dispose();
  }
}
