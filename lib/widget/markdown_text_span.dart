import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class MarkdownMatch {
  final String text;
  final TextStyle style;
  final String? replaceTextKey;
  final String? replaceText;

  MarkdownMatch({
    required this.text,
    required this.style,
    this.replaceTextKey,
    this.replaceText,
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
    replaceTextKey: "*",
    replaceText: " ",
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
          if (markdownMatch.replaceTextKey == null ||
              markdownMatch.replaceText == null) {
            children.add(TextSpan(
              text: match[0],
              style: style?.merge(markdownMatch.style),
            ));
            return "";
          }

          if (markdownMatch.replaceTextKey != null &&
              markdownMatch.replaceText != null) {
            children.add(TextSpan(
              text: match[0]!.replaceAll(
                  markdownMatch.replaceTextKey!, markdownMatch.replaceText!),
              style: style?.merge(markdownMatch.style),
            ));
            return "";
          }

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
