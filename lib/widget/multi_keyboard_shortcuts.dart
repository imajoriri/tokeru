import 'package:flutter/material.dart';
import 'package:quick_flutter/widget/shortcut_intent.dart';

class MultiKeyBoardShortcuts extends StatelessWidget {
  const MultiKeyBoardShortcuts({
    super.key,
    required this.onCommandEnter,
    required this.onEsc,
    required this.child,
  });

  final VoidCallback onCommandEnter;
  final VoidCallback onEsc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        CommandEnterIntent: CallbackAction(
          onInvoke: (intent) {
            onCommandEnter();
            return null;
          },
        ),
        EscIntent: CallbackAction(
          onInvoke: (intent) {
            onEsc();
            return null;
          },
        ),
      },
      child: child,
    );
  }
}
