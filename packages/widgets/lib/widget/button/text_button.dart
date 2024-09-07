import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widgets.dart';

enum AppTextButtonSize {
  small,
  medium,
}

enum AppTextButtonType {
  text,
  textSelected,
  textNotSelected,
  textSubtle,
  filled,
}

/// テキストボタン。
class AppTextButton extends HookWidget {
  const AppTextButton.medium({
    super.key,
    required this.onPressed,
    required this.text,
    this.skipTraversal = false,
    this.buttonType = AppTextButtonType.text,
    this.icon,
    this.isLoading = false,
  })  : iconSize = 16,
        type = AppTextButtonSize.medium;

  const AppTextButton.small({
    super.key,
    required this.onPressed,
    required this.text,
    this.skipTraversal = false,
    this.buttonType = AppTextButtonType.text,
    this.icon,
    this.isLoading = false,
  })  : iconSize = 16,
        type = AppTextButtonSize.small;

  final void Function()? onPressed;

  final Widget text;

  final bool skipTraversal;

  final double iconSize;

  final Widget? icon;

  final AppTextButtonType buttonType;

  final AppTextButtonSize type;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textStyle = switch (type) {
      AppTextButtonSize.small => context.appTextTheme.labelSmall,
      AppTextButtonSize.medium => context.appTextTheme.labelMidium,
    };
    final containerColor = switch (buttonType) {
      AppTextButtonType.text => context.appColors.onSurface,
      AppTextButtonType.textSubtle => context.appColors.onSurfaceSubtle,
      AppTextButtonType.textSelected => context.appColors.onSurface,
      AppTextButtonType.textNotSelected => context.appColors.onSurfaceSubtle,
      AppTextButtonType.filled => context.appColors.onPrimary,
    };
    final style = AppButtonStyle(
      contentColor: containerColor,
      backgroundColor: switch (buttonType) {
        AppTextButtonType.text => context.appColors.surface,
        AppTextButtonType.textSubtle => context.appColors.surface,
        AppTextButtonType.textSelected =>
          context.appColors.onSurface.withOpacity(0.10),
        AppTextButtonType.textNotSelected => context.appColors.surface,
        AppTextButtonType.filled => context.appColors.primary,
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
    return AppButton(
      onPressed: onPressed,
      skipTraversal: skipTraversal,
      style: style,
      child: Stack(
        children: [
          Opacity(
            opacity: isLoading ? 0 : 1,
            child: Padding(
              padding: switch (type) {
                AppTextButtonSize.small => EdgeInsets.symmetric(
                    vertical: context.appSpacing.smallX,
                    horizontal: context.appSpacing.small,
                  ),
                AppTextButtonSize.medium =>
                  EdgeInsets.all(context.appSpacing.small),
              },
              child: DefaultTextStyle.merge(
                style: textStyle,
                child: IconTheme.merge(
                  data: IconThemeData(
                    size: iconSize,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        SizedBox(width: context.appSpacing.smallX),
                      ],
                      text,
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: CupertinoActivityIndicator(
                radius: iconSize / 2,
                color: containerColor,
              ),
            ),
        ],
      ),
    );
  }
}
