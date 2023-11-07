import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// replaceTextやbeforeWidgetSpanを指定して、トータル同じテキストの量にする
class MarkdownMatch {
  final String text;
  final TextStyle? style;
  final MarkdownReplaceText? replaceText;
  final InlineSpan? beforeWidgetSpan;

  MarkdownMatch({
    required this.text,
    this.style,
    this.replaceText,
    this.beforeWidgetSpan,
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
      afterText: " ",
    ),
  ),
  // list
  MarkdownMatch(
    text: r"(?:^|\n)-\s.*",
    replaceText: MarkdownReplaceText(
      beforeText: "- ",
      afterText: " ",
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
      afterText: " ",
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
  }) : super(
          children: _buildChildren(text, style, matches),
        );

  static List<InlineSpan> _buildChildren(
    String text,
    TextStyle? style,
    List<MarkdownMatch> matches,
  ) {
    {
      final pattern = RegExp(
          matches.map((match) {
            return match.text;
          }).join('|'),
          multiLine: true);
      final List<InlineSpan> children = [];

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
            children: [
              if (!isFirstLine) const TextSpan(text: '\n'),
              if (markdownMatch.beforeWidgetSpan != null)
                markdownMatch.beforeWidgetSpan!,
              if (isFirstLine)
                TextSpan(
                    children: _buildChildren(
                        newText, style?.merge(markdownMatch.style), matches))
              else
                // widgetSpanの前に改行を入れた分、1文字目の改行を削除
                TextSpan(
                    children: _buildChildren(newText.substring(1),
                        style?.merge(markdownMatch.style), matches)),
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
