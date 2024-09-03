import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tokeru_widgets/widget/color/status_color.dart';

class AppButtonStyle {
  /// ボタンのコンテンツ(中身)のカラー。
  ///
  /// [IconTheme]、[DefaultTextStyle]を使用してコンテンツのカラーとして使用される。
  /// ホバーやフォーカス時のカラーは、このカラーを元に計算される。
  final Color contentColor;

  /// ボタンの背景色。
  final Color backgroundColor;

  /// ホバー時のカラー。
  ///
  /// nullの場合、[contentColor.hovered]が使用される。
  final Color? hoveredColor;

  /// フォーカス時のカラー。
  ///
  /// nullの場合、[contentColor.focused]が使用される。
  final Color? focusedColor;

  /// プレス時のカラー。
  ///
  /// nullの場合、[contentColor.pressed]が使用される。
  final Color? pressedColor;

  /// Disabled時のカラー。
  ///
  /// nullの場合、[contentColor.disabled]が使用される。
  final Color? disabledColor;

  /// ボタンのカラーが変更時にアニメーションするかどうか。
  final bool stateColorAnimated;

  /// ボタンの背景色のカラーが変更時にアニメーションするかどうか。
  final bool backgroundColorAnimated;

  /// ボタンの形状。
  final ShapeBorder shape;

  const AppButtonStyle({
    required this.contentColor,
    required this.backgroundColor,
    this.hoveredColor,
    this.focusedColor,
    this.pressedColor,
    this.disabledColor,
    this.stateColorAnimated = true,
    this.backgroundColorAnimated = true,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  });
}

/// ボタンとしての基本的な機能を持つWidget
///
/// - Hovered, Focused, Pressedの状態に応じて、カラーを変更する。
/// - Pressed状態の時にbounceする。([bounce]がtrueの時)
class AppButton extends HookWidget {
  const AppButton({
    super.key,
    required this.style,
    required this.child,
    this.onPressed,
    this.bounce = true,
    this.skipTraversal = false,
  });

  final AppButtonStyle style;

  final Widget child;

  /// ボタンが押された時のコールバック。
  final void Function()? onPressed;

  /// Pressed状態の時にbounceするかどうか。
  final bool bounce;

  final bool skipTraversal;

  bool get enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    final focus = useState(false);
    final pressed = useState(false);

    late final Color overlayColor;
    if (!enabled) {
      overlayColor = style.disabledColor ?? style.contentColor.disabled;
    } else if (pressed.value) {
      overlayColor = style.pressedColor ?? style.contentColor.pressed;
    } else if (hover.value) {
      overlayColor = style.hoveredColor ?? style.contentColor.hovered;
    } else if (focus.value) {
      overlayColor = style.focusedColor ?? style.contentColor.focused;
    } else {
      overlayColor = style.backgroundColor.withOpacity(0);
    }

    // ボタンの背景色のアニメーション時間。
    final backgroundColorDuration =
        Duration(milliseconds: style.backgroundColorAnimated ? 150 : 0);

    // ボタンのステートによるカラー変更のアニメーション時間。
    final stateColorduration =
        Duration(milliseconds: style.stateColorAnimated ? 150 : 0);

    // ボタンのbounceアニメーション時間。
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
        focusNode: useFocusNode(skipTraversal: skipTraversal || !enabled),
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
                    duration: backgroundColorDuration,
                    decoration: ShapeDecoration(
                      color: style.backgroundColor,
                      shape: style.shape,
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
                    duration: stateColorduration,
                    decoration: ShapeDecoration(
                      color: overlayColor,
                      shape: style.shape,
                    ),
                  ),
                ),

                // Content layer
                IconTheme.merge(
                  data: IconThemeData(
                    color: style.contentColor,
                  ),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: style.contentColor,
                    ),
                    child: child,
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
