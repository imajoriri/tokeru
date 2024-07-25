import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tokeru_widgets/model/ogp/ogp.dart';
import 'package:tokeru_widgets/widget/skeleton/skeleton_card.dart';
import 'package:tokeru_widgets/widget/skeleton/skeleton_text.dart';
import 'package:tokeru_widgets/widget/theme/app_theme.dart';

/// ogp の 画像の横幅
const double _ogpImageWidth = 120;

/// ogp の 画像の縦幅
const double _ogpImageHeight = 63;

/// URLプレビューのカード。
class UrlPreviewCard extends StatelessWidget {
  final Ogp ogp;

  /// タップ時の処理。
  final void Function()? onTap;

  const UrlPreviewCard({
    super.key,
    required this.ogp,
    this.onTap,
  });

  const factory UrlPreviewCard.loading() = _Skeleton;

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
                      ogp.title,
                      style: context.appTextTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.appSpacing.smallX),
                    Text(
                      ogp.description,
                      style: context.appTextTheme.bodySmall
                          .copyWith(color: context.appColors.onSurfaceSubtle),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.appSpacing.medium),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: ogp.imageUrl,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
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
          ogp: const Ogp(
            url: '',
            title: '',
            description: '',
            imageUrl: '',
          ),
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
