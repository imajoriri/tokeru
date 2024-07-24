import 'package:flutter_linkify/flutter_linkify.dart';

/// [text]の中から[Uri]を抽出する
List<Uri> getLinks({
  required String text,
}) {
  const linkifier = UrlLinkifier();
  var list = <LinkifyElement>[TextElement(text)];
  list = linkifier.parse(list, const LinkifyOptions());

  return list
      .whereType<LinkableElement>()
      .map((element) => Uri.parse(element.url))
      .toList();
}
