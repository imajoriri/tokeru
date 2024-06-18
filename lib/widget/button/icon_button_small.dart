import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

/// 小さめのアイコンボタン。
class IconButtonSmall extends HookConsumerWidget {
  final Widget icon;
  final void Function() onPressed;
  final String? tooltip;

  const IconButtonSmall({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hover = useState(false);
    final focus = useState(false);
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
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
          child: Container(
            padding: EdgeInsets.all(context.appSpacing.smallX),
            decoration: BoxDecoration(
              color: hover.value || focus.value
                  ? context.appColors.backgroundHovered
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconTheme.merge(
              child: icon,
              data: IconThemeData(
                size: 20,
                color: hover.value || focus.value
                    ? context.appColors.iconHovered
                    : context.appColors.iconDefault,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
