import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MarkdownTextField extends HookConsumerWidget {
  const MarkdownTextField({
    required this.controller,
    required this.focus,
    this.maxLines,
    this.expands = false,
    this.hintText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focus;
  final int? maxLines;
  final bool expands;
  final String? hintText;

  bool listControl(String key) {
    final text = controller.text;
    final lines = text.split('\n');
    final baseOffset = controller.selection.baseOffset;
    // 現在のカーソルがいるよりも前のテキストの改行の数を取得
    final previousLineCount =
        text.substring(0, controller.selection.baseOffset).split('\n').length;

    final currentLineIndex = previousLineCount - 1;
    final previousLineIndex = currentLineIndex - 1;
    // 現在の行が'- 'と一致する場合、現在の行を空白にする
    if (lines[previousLineIndex] == key) {
      lines[previousLineIndex] = '';
      // 現在の行を消す
      lines.removeAt(currentLineIndex);
      controller.text = lines.join('\n');
      controller.selection = TextSelection(
        baseOffset: baseOffset - key.length - 1,
        extentOffset: baseOffset - key.length - 1,
      );
      return true;
    }

    // 1つ前の行がリストの時かつ、空白のテキストではない場合
    if (lines[previousLineIndex].startsWith(key) &&
        lines[previousLineIndex] != key) {
      lines[currentLineIndex] = '$key${lines[currentLineIndex]}';
      controller.text = lines.join('\n');
      controller.selection = TextSelection(
        baseOffset: baseOffset + key.length,
        extentOffset: baseOffset + key.length,
        isDirectional: true,
      );
      return true;
    }
    return false;
  }

  void onTapEnter() {
    if (listControl('- [ ] ')) return;
    if (listControl('- [x] ')) return;
    if (listControl('- ')) return;
    if (listControl('* ')) return;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previousText = useState(controller.text);

    return TextField(
      focusNode: focus,
      controller: controller,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).hintColor)),
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      expands: expands,
      onChanged: (value) {
        final text = controller.text;
        // 入力された文字数が増え、かつ改行された場合
        if (previousText.value.split('\n').length < text.split('\n').length) {
          onTapEnter();
        }
        previousText.value = controller.text;
      },
    );
  }
}
