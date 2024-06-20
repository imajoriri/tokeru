import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

/// 小さめのテキストボタン。
class TextButtonSmall extends HookWidget {
  const TextButtonSmall({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);
    final focus = useState(false);
    return GestureDetector(
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) => onPressed(),
          ),
        },
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
        },
        onShowFocusHighlight: (value) => focus.value = value,
        onShowHoverHighlight: (value) => hover.value = value,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hover.value || focus.value
                ? context.appColors.backgroundHovered
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DefaultTextStyle(
            style: context.appTextTheme.labelLarge,
            child: child,
          ),
        ),
      ),
    );
  }
}
