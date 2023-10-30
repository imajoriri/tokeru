import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MarkdownTextField extends HookConsumerWidget {
  const MarkdownTextField({
    required this.onSubmit,
    required this.controller,
    required this.focus,
    Key? key,
  }) : super(key: key);

  final Function() onSubmit;
  final MarkdownTextEditingController controller;
  final FocusNode focus;

  void listControl(String key) {
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
        baseOffset: baseOffset - 3,
        extentOffset: baseOffset - 3,
      );
      return;
    }

    // 1つ前の行がリストの時かつ、空白のテキストではない場合
    if (lines[previousLineIndex].startsWith(key) &&
        lines[previousLineIndex] != key) {
      lines[currentLineIndex] = '$key${lines[currentLineIndex]}';
      controller.text = lines.join('\n');
      controller.selection = TextSelection(
        baseOffset: baseOffset + 2,
        extentOffset: baseOffset + 2,
      );
      return;
    }
  }

  void onTapEnter() {
    listControl('- ');
    listControl('* ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previousText = useState(controller.text);

    return TextField(
      focusNode: focus,
      controller: controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
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

// TODO: 解析する
class MarkdownTextEditingController extends TextEditingController {
  final Map<String, TextStyle> map;
  final Pattern pattern;

  MarkdownTextEditingController(
      {this.map = const {
        // r"@.\w+": TextStyle(
        //   color: Colors.blue,
        // ),
        // # タイトル1
        r"#.\w+": TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        // イタリック
        r'_(.*?)\_': TextStyle(
          fontStyle: FontStyle.italic,
        ),
        // 取り消し線
        '~(.*?)~': TextStyle(
          decoration: TextDecoration.lineThrough,
        ),
        // bold
        r'\*(.*?)\*': TextStyle(
          fontWeight: FontWeight.bold,
        ),
      }})
      : pattern = RegExp(
            map.keys.map((key) {
              return key;
            }).join('|'),
            multiLine: true);

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
    final List<InlineSpan> children = [];
    String? patternMatched;
    String? formatText;
    TextStyle? myStyle;
    print(pattern);
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = map[map.keys.firstWhere(
          (e) {
            bool ret = false;
            RegExp(e).allMatches(text).forEach((element) {
              if (element.group(0) == match[0]) {
                patternMatched = e;
                ret = true;
              }
            });
            return ret;
          },
        )];

        if (patternMatched == r"_(.*?)\_") {
          formatText = match[0]!.replaceAll("_", " ");
        } else if (patternMatched == r'\*(.*?)\*') {
          formatText = match[0]!.replaceAll("*", " ");
        } else if (patternMatched == "~(.*?)~") {
          formatText = match[0]!.replaceAll("~", " ");
        } else if (patternMatched == r'```(.*?)```') {
          formatText = match[0]!.replaceAll("```", "   ");
        } else {
          formatText = match[0];
        }

        children.add(TextSpan(
          text: formatText,
          style: style!.merge(myStyle),
        ));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}
