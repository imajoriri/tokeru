import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widgets.dart';

/// 小さめのアイコンボタン。
class AppIconButton extends HookWidget {
  /// アイコンのWidget。
  final Widget icon;

  /// クリック時の処理。
  final void Function() onPressed;

  /// ツールチップ。
  final String? tooltip;

  /// アイコンのサイズ。
  final double iconSize;

  /// パディング。
  final EdgeInsets padding;

  /// ボタンの角の丸み。
  final double radius;

  /// Borderを表示するかどうか。
  final bool showBorder;

  final bool bounce;

  const AppIconButton.medium({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.showBorder = false,
    this.bounce = true,
  })  : iconSize = 20,
        padding = const EdgeInsets.all(8),
        radius = 8;

  const AppIconButton.small({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.showBorder = false,
    this.bounce = true,
  })  : iconSize = 16,
        padding = const EdgeInsets.all(8),
        radius = 8;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: AppButton(
        bounce: bounce,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        onPressed: onPressed,
        contentColor: context.appColors.onSurface,
        backgroundColor: context.appColors.surface,
        child: Container(
          padding: EdgeInsets.all(context.appSpacing.smallX),
          decoration: showBorder
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(
                    color: context.appColors.outline,
                  ),
                )
              : null,
          child: IconTheme.merge(
            child: icon,
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
