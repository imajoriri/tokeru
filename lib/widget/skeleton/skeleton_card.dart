import 'package:flutter/cupertino.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: width,
        height: height,
        color: context.appColors.backgroundSkeleton,
      ),
    );
  }
}
