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

  /// Borderを表示するかどうか。
  final bool showBorder;

  const AppIconButton.medium({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.showBorder = false,
  })  : iconSize = 20,
        padding = const EdgeInsets.all(8);

  const AppIconButton.small({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.showBorder = false,
  })  : iconSize = 16,
        padding = const EdgeInsets.all(8);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: AppButton(
        onPressed: onPressed,
        containerColor: context.appColors.onSurface,
        backgroundColor: context.appColors.surface,
        child: Container(
          padding: EdgeInsets.all(context.appSpacing.smallX),
          // border
          decoration: showBorder
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
