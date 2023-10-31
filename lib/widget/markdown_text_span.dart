import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

class MarkdownTextSpan extends TextSpan {
  MarkdownTextSpan({
    TextStyle? style,
    required String text,
    required Pattern pattern,
    required List<MarkdownMatch> matches,
    GestureRecognizer? recognizer,
  }) : super(
            style: style,
            children: _buildChildren(text, style, pattern, matches),
            recognizer: recognizer);

  static List<InlineSpan> _buildChildren(
    String text,
    TextStyle? style,
    Pattern pattern,
    List<MarkdownMatch> matches,
  ) {
    {
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
              style: style!.merge(markdownMatch.style),
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
