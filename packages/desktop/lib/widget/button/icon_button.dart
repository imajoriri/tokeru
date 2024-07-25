import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_desktop/widget/theme/app_theme.dart';
import 'package:tokeru_widgets/widgets.dart';

/// 小さめのアイコンボタン。
class AppIconButton extends HookWidget {
  /// アイコンのWidget。
  final Widget icon;

  /// クリック時の処理。
  final void Function() onPressed;

  /// ツールチップ。
  final String tooltip;

  /// アイコンのサイズ。
  final double iconSize;

  /// パディング。
  final EdgeInsets padding;

  const AppIconButton.medium({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  })  : iconSize = 20,
        padding = const EdgeInsets.all(8),
        super(key: key);

  const AppIconButton.small({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  })  : iconSize = 16,
        padding = const EdgeInsets.all(8),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: onPressed,
      containerColor: context.appColors.onSurface,
      backgroundColor: context.appColors.surface,
      child: Padding(
        padding: EdgeInsets.all(context.appSpacing.smallX),
        child: IconTheme.merge(
          child: icon,
          data: IconThemeData(
            size: iconSize,
            color: context.appColors.onSurface,
          ),
        ),
      ),
    );
  }
}
