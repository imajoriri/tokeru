import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// replaceTextやbeforeWidgetSpanを指定して、トータル同じテキストの量にする
class MarkdownMatch {
  final String text;
  final TextStyle? style;
  final MarkdownReplaceText? replaceText;
  final InlineSpan? beforeWidgetSpan;
  final String Function(String oldValue)? onTap;

  MarkdownMatch({
    required this.text,
    this.style,
    this.replaceText,
    this.beforeWidgetSpan,
    this.onTap,
  });
}

class MarkdownReplaceText {
  final String beforeText;
  final String afterText;

  MarkdownReplaceText({
    required this.beforeText,
    required this.afterText,
  });
}

final List<MarkdownMatch> matches = [
  // # タイトル1
  MarkdownMatch(
    text: r"(?:^|\n)#\s.+",
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  ),
  // ## タイトル2
  MarkdownMatch(
    text: r"(?:^|\n)##\s.+",
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  // ### タイトル3
  MarkdownMatch(
    text: r"(?:^|\n)###\s.+",
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  ),
  // 取り消し線
  MarkdownMatch(
    text: "~(.*?)~",
    style: const TextStyle(
      decoration: TextDecoration.lineThrough,
    ),
  ),
  // bold
  MarkdownMatch(
    text: r"\*(.*?)\*",
    style: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    replaceText: MarkdownReplaceText(
      beforeText: "*",
      afterText: "",
    ),
  ),
  // checklist
  MarkdownMatch(
    text: r"(?:^|\n)-\s\[( )\]\s.*",
    replaceText: MarkdownReplaceText(
      beforeText: "- [ ] ",
      afterText: "",
      // afterText: "\u{200C}\u{200C}\u{200C}\u{200C}\u{200C}",
    ),
    onTap: (value) {
      return value.replaceAll("- [ ] ", "- [x] ");
    },
    beforeWidgetSpan: const WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Icon(Icons.check_box_outline_blank, size: 16),
      ),
    ),
  ),
  MarkdownMatch(
    text: r"(?:^|\n)-\s\[(x|X|)\]\s.*",
    replaceText: MarkdownReplaceText(
      beforeText: "- [x] ",
      afterText: "",
    ),
    onTap: (value) {
      return value.replaceAll("- [x] ", "- [ ] ");
    },
    beforeWidgetSpan: const WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Icon(Icons.check_box, size: 16),
      ),
    ),
  ),
  // list
  MarkdownMatch(
    text: r"(?:^|\n)-\s.*",
    replaceText: MarkdownReplaceText(
      beforeText: "- ",
      afterText: "",
    ),
    beforeWidgetSpan: const WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Icon(Icons.brightness_1, size: 8),
      ),
    ),
  ),
  MarkdownMatch(
    text: r"(?:^|\n)\*\s.*",
    replaceText: MarkdownReplaceText(
      beforeText: "* ",
      afterText: "",
    ),
    beforeWidgetSpan: const WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Icon(Icons.brightness_1, size: 8),
      ),
    ),
  ),
];

class MarkdownTextSpan extends TextSpan {
  MarkdownTextSpan({
    super.style,
    super.recognizer,
    required String text,
    this.onChanged,
  }) : super(
          children: _buildChildren(text, style, matches, onChanged),
        );
  final Function(String value)? onChanged;

  static List<InlineSpan> _buildChildren(
    String text,
    TextStyle? style,
    List<MarkdownMatch> matches,
    Function(String value)? onChanged,
  ) {
    {
      final pattern = RegExp(
          matches.map((match) {
            return match.text;
          }).join('|'),
          multiLine: true);
      final List<InlineSpan> children = [];

      onTap(MarkdownMatch markdownMatch, Match match) {
        final newValue = markdownMatch.onTap?.call(match[0]!);
        // マッチしている部分をnewValueに置き換える
        if (newValue == null) return;
        final res = text.replaceRange(match.start, match.end, newValue);
        onChanged?.call(res);
      }

      text.splitMapJoin(
        pattern,
        // マッチした文字列の回数呼ばれる
        onMatch: (Match match) {
          final markdownMatch = matches.firstWhereOrNull(
            (e) => RegExp(e.text)
                .allMatches(text)
                .any((element) => element.group(0) == match[0]),
          );

          if (markdownMatch == null) {
            children.add(TextSpan(
              text: match[0],
            ));
            return "";
          }

          final newText = markdownMatch.replaceText == null
              ? match[0]!
              : match[0]!.replaceAll(markdownMatch.replaceText!.beforeText,
                  markdownMatch.replaceText!.afterText);

          if (markdownMatch.beforeWidgetSpan == null) {
            children.add(TextSpan(
              text: newText,
              style: style?.merge(markdownMatch.style),
            ));
            return "";
          }

          final isFirstLine = !match[0]!.startsWith('\n');
          children.add(TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap.call(markdownMatch, match);
              },
            children: [
              if (!isFirstLine) const TextSpan(text: '\n'),
              if (markdownMatch.beforeWidgetSpan != null)
                markdownMatch.beforeWidgetSpan!,
              if (isFirstLine)
                TextSpan(
                  text: newText,
                  style: style?.merge(markdownMatch.style),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      onTap.call(markdownMatch, match);
                    },
                )
              else
                // widgetSpanの前に改行を入れた分、1文字目の改行を削除
                TextSpan(
                  text: newText.substring(1),
                  style: style?.merge(markdownMatch.style),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      onTap.call(markdownMatch, match);
                    },
                ),
            ],
          ));

          return "";
        },
        onNonMatch: (String text) {
          children.add(TextSpan(text: text, style: style));
          return "";
        },
      );

      return children;
    }
  }
}
