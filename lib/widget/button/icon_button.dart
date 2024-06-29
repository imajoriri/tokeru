import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

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
    final hover = useState(false);
    final focus = useState(false);

    const duration = Duration(milliseconds: 150);

    final animationController = useAnimationController(duration: duration);

    final backgroundColorAnimation = ColorTween(
      begin: context.appColors.backgroundDefault,
      end: context.appColors.backgroundHovered,
    ).animate(animationController);

    final iconOpacityAnimation = Tween<double>(begin: 0.8, end: 1.0);

    useEffect(
      () {
        if (hover.value || focus.value) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
        return null;
      },
      [hover.value, focus.value],
    );

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: FocusableActionDetector(
          onShowHoverHighlight: (value) => hover.value = value,
          onShowFocusHighlight: (value) => focus.value = value,
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          },
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) => onPressed(),
            ),
          },
          mouseCursor: SystemMouseCursors.click,
          child: AnimatedBuilder(
            animation: backgroundColorAnimation,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.all(context.appSpacing.smallX),
                decoration: BoxDecoration(
                  color: backgroundColorAnimation.value,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Opacity(
                  opacity: iconOpacityAnimation.evaluate(animationController),
                  child: IconTheme.merge(
                    child: icon,
                    data: IconThemeData(
                      size: iconSize,
                      color: context.appColors.iconDefault,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
