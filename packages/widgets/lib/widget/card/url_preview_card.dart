import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:tokeru_widgets/widget/skeleton/skeleton_card.dart';
import 'package:tokeru_widgets/widget/skeleton/skeleton_text.dart';
import 'package:tokeru_widgets/widget/theme/app_theme.dart';

/// ogp の 画像の横幅
const double _ogpImageWidth = 120;

/// ogp の 画像の縦幅
const double _ogpImageHeight = 63;

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

/// URLプレビューのカード。
class UrlPreviewCard extends StatelessWidget {
  const UrlPreviewCard({
    super.key,
    required this.url,
    required this.title,
    required this.description,
    this.imageUrl,
    this.onTap,
  });

  const factory UrlPreviewCard.loading() = _Skeleton;
  final String url;
  final String title;
  final String description;
  final String? imageUrl;

  /// タップ時の処理。
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(context.appSpacing.small),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.appColors.outline,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.appTextTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.appSpacing.smallX),
                    Text(
                      description,
                      style: context.appTextTheme.bodySmall
                          .copyWith(color: context.appColors.onSurfaceSubtle),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.appSpacing.medium),
              if (imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: _ogpImageWidth,
                    height: _ogpImageHeight,
                    fadeInDuration: const Duration(milliseconds: 150),
                    fadeOutDuration: const Duration(milliseconds: 150),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: context.appColors.skeleton,
                      width: _ogpImageWidth,
                      height: _ogpImageHeight,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              else
                const SizedBox(width: 0, height: _ogpImageHeight),
            ],
          ),
        ),
      ),
    );
  }
}

class _Skeleton extends UrlPreviewCard {
  const _Skeleton()
      : super(
          url: '',
          title: '',
          description: '',
          imageUrl: '',
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.appSpacing.small),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.appColors.outline,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonText(width: 100, style: context.appTextTheme.bodySmall),
              SizedBox(height: context.appSpacing.smallX),
              SkeletonText(
                width: 200,
                style: context.appTextTheme.bodySmall,
                lineLength: 2,
              ),
            ],
          ),
          const Spacer(),
          const SkeletonCard(
            width: _ogpImageWidth,
            height: _ogpImageHeight,
          ),
        ],
      ),
    );
  }
}
