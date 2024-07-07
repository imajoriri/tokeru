import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

/// チャットを送信するためのButton。
class SubmitButton extends HookWidget {
  final void Function()? onPressed;

  const SubmitButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    final focus = useState(false);
    Color getBackgroundColor(BuildContext context) {
      if (onPressed == null) {
        return context.appColors.backgroundDisabled;
      }
      if (hover.value || focus.value) {
        return context.appColors.primaryHovered;
      }
      return context.appColors.primary;
    }

    return GestureDetector(
      onTap: onPressed,
      child: FocusableActionDetector(
        onShowHoverHighlight: (value) => hover.value = value,
        onShowFocusHighlight: (value) => focus.value = value,
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        },
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => onPressed?.call(),
          ),
        },
        mouseCursor: onPressed != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            vertical: context.appSpacing.smallX,
            horizontal: context.appSpacing.small,
          ),
          decoration: BoxDecoration(
            color: getBackgroundColor(context),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconTheme.merge(
            child: const Icon(Icons.send),
            data: IconThemeData(
              size: 16,
              color: context.appColors.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
