import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_desktop/widget/theme/app_theme.dart';

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
    const animationDuration = Duration(milliseconds: 100);
    final pressed = useState(false);
    onTapCheck() async {
      if (!pressed.value) {
        pressed.value = true;
        await Future.delayed(animationDuration);
      }
      pressed.value = false;
      onPressed?.call(!checked);
    }

    const minScale = 0.9;
    const widgetSize = 16.0;

    return GestureDetector(
      onTapDown: (detail) => pressed.value = true,
      onTapCancel: () => pressed.value = false,
      onTap: onTapCheck,
      child: FocusableActionDetector(
        focusNode: useFocusNode(skipTraversal: true),
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => onTapCheck.call(),
          ),
        },
        mouseCursor: onPressed != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: AnimatedScale(
          duration: animationDuration,
          scale: pressed.value ? minScale : 1.0,
          child: AnimatedContainer(
            duration: animationDuration,
            width: widgetSize,
            height: widgetSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: checked
                    ? checkedColor ?? context.appColors.onSurfaceSubtle
                    : uncheckedColor ?? context.appColors.onSurface,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: checked ? 1.0 : 0.0,
              child: Icon(
                Icons.check_rounded,
                size: 12,
                color: checked
                    ? checkedColor ?? context.appColors.onSurfaceSubtle
                    : uncheckedColor ?? context.appColors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
