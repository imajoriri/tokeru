import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

/// Tokeruで使用するチェックボタン。
class CheckButton extends HookWidget {
  const CheckButton({
    Key? key,
    required this.checked,
    this.onPressed,
    this.uncheckedColor,
    this.checkedColor,
  }) : super(key: key);

  final bool checked;

  /// ボタンが押されたときの処理。
  final void Function(bool)? onPressed;

  /// チェックされていないときのカラー。
  ///
  /// 指定しない場合は、[AppTheme.iconDefault]が使用される。
  final Color? uncheckedColor;

  /// チェックされているときのカラー。
  ///
  /// 指定しない場合は、[AppTheme.iconSubtle]が使用される。
  final Color? checkedColor;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );

    final colorAnimation = ColorTween(
      begin: uncheckedColor ?? context.appColors.iconDefault,
      end: checkedColor ?? context.appColors.iconSubtle,
    ).animate(animationController);

    useEffect(
      () {
        if (checked) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
        return;
      },
      [checked],
    );

    final widgetScale = useState(1.0);

    return GestureDetector(
      onTapDown: (detail) => widgetScale.value = 0.9,
      onTapCancel: () => widgetScale.value = 1.0,
      onTapUp: (details) => widgetScale.value = 1.0,
      onTap: () => onPressed?.call(!checked),
      child: FocusableActionDetector(
        focusNode: useFocusNode(skipTraversal: true),
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => onPressed?.call(!checked),
          ),
        },
        mouseCursor: onPressed != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 100),
          scale: widgetScale.value,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: colorAnimation.value!,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: animationController.value,
                  child: Icon(
                    Icons.check_rounded,
                    size: 12,
                    color: colorAnimation.value,
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
