import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widget/color/status_color.dart';

/// ボタンとして必要最低限の機能を持つWidget
class AppButton extends HookWidget {
  const AppButton({
    super.key,
    required this.child,
    required this.containerColor,
    required this.backgroundColor,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    this.onPressed,
    this.bounce = true,
  });

  final Widget child;

  /// ボタンのコンテンツ(中身)のカラー。
  ///
  /// アイコンやテキストのカラーとして使用される。
  /// ホバーやフォーカス時のカラーは、このカラーを元に計算される。
  final Color containerColor;

  /// ボタンの背景色。
  final Color backgroundColor;
  final void Function()? onPressed;

  bool get enabled => onPressed != null;

  final ShapeBorder shape;

  /// Pressed状態の時にbounceするかどうか。
  final bool bounce;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    final focus = useState(false);
    final pressed = useState(false);

    late final Color overlayColor;
    if (!enabled) {
      overlayColor = containerColor.disabled;
    } else if (pressed.value) {
      overlayColor = containerColor.pressed;
    } else if (hover.value) {
      overlayColor = containerColor.hovered;
    } else if (focus.value) {
      overlayColor = containerColor.focused;
    } else {
      overlayColor = containerColor.withOpacity(0);
    }

    const duration = Duration(milliseconds: 150);
    const bounceDuration = Duration(milliseconds: 200);

    void onInvoke() {
      if (onPressed == null) {
        return;
      }
      if (!pressed.value) {
        pressed.value = true;
      }
      onPressed?.call();
      if (context.mounted) {
        pressed.value = false;
      }
      return;
    }

    return Semantics(
      container: true,
      child: FocusableActionDetector(
        focusNode: useFocusNode(skipTraversal: !enabled),
        onShowHoverHighlight: (value) => hover.value = value,
        onShowFocusHighlight: (value) => focus.value = value,
        mouseCursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        actions: <Type, Action<Intent>>{
          ActivateIntent:
              CallbackAction<ActivateIntent>(onInvoke: (_) => onInvoke()),
          ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
            onInvoke: (_) => onInvoke(),
          ),
        },
        child: GestureDetector(
          onTap: onInvoke,
          onTapDown: (detail) => pressed.value = true,
          onTapCancel: () => pressed.value = false,
          child: AnimatedScale(
            duration: bounceDuration,
            curve: Curves.easeOutExpo,
            scale: pressed.value && enabled && bounce ? 0.95 : 1.0,
            child: Stack(
              children: [
                // Container layer
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: duration,
                    decoration: ShapeDecoration(
                      color: backgroundColor,
                      shape: shape,
                    ),
                  ),
                ),

                // State layer
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: duration,
                    decoration: ShapeDecoration(
                      color: overlayColor,
                      shape: shape,
                    ),
                  ),
                ),

                // Content layer
                IconTheme.merge(
                  data: IconThemeData(
                    color: containerColor,
                  ),
                  child: DefaultTextStyle.merge(
                    child: child,
                    style: TextStyle(
                      color: containerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
