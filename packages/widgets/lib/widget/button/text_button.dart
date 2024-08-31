import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widgets.dart';

enum _AppTextButtonType {
  small,
  medium,
}

/// テキストボタン。
class AppTextButton extends HookWidget {
  const AppTextButton.medium({
    super.key,
    required this.onPressed,
    required this.text,
    this.skipTraversal = false,
  })  : iconSize = 14,
        type = _AppTextButtonType.medium;

  const AppTextButton.small({
    super.key,
    required this.onPressed,
    required this.text,
    this.skipTraversal = false,
  })  : iconSize = 12,
        type = _AppTextButtonType.small;

  final void Function()? onPressed;

  final Widget text;

  final bool skipTraversal;

  final double iconSize;

  // ignore: library_private_types_in_public_api
  final _AppTextButtonType type;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (type) {
      _AppTextButtonType.small => context.appTextTheme.labelSmall,
      _AppTextButtonType.medium => context.appTextTheme.labelMidium,
    };
    return AppButton(
      onPressed: onPressed,
      skipTraversal: skipTraversal,
      contentColor: context.appColors.onSurface,
      backgroundColor: context.appColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: switch (type) {
          _AppTextButtonType.small => EdgeInsets.symmetric(
              vertical: context.appSpacing.smallX,
              horizontal: context.appSpacing.small,
            ),
          _AppTextButtonType.medium => EdgeInsets.all(context.appSpacing.small),
        },
        child: DefaultTextStyle(
          style: textStyle,
          child: IconTheme.merge(
            child: text,
            data: IconThemeData(
              size: iconSize,
              color: context.appColors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
