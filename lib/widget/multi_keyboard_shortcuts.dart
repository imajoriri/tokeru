import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommandEnterIntent extends Intent {}

class EscIntent extends Intent {}

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
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(
          LogicalKeyboardKey.meta,
          LogicalKeyboardKey.enter,
        ): CommandEnterIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.escape,
        ): EscIntent(),
      },
      child: Actions(
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
      ),
    );
  }
}
