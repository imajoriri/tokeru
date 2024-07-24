import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/actions/reload/reload_action.dart';
import 'package:quick_flutter/widget/actions/toggle_focus/toggle_focus_action.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';

/// [CallbackShortcuts]の中でRefを使うためにラップしたWidgetクラス
class AppCallbackShortcuts extends ConsumerWidget {
  const AppCallbackShortcuts({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FocusScope(
      child: Shortcuts(
        shortcuts: {
          ShortcutActivatorType.newTodo.shortcutActivator:
              const NewTodoIntent(),
          ShortcutActivatorType.reload.shortcutActivator: const ReloadIntent(),
          ShortcutActivatorType.switchFocusChat.shortcutActivator:
              const ToggleFocusIntent(),
          ShortcutActivatorType.switchFocusTodo.shortcutActivator:
              const ToggleFocusIntent(),
        },
        child: Actions(
          dispatcher: _LoggingActionDispatcher(),
          actions: {
            NewTodoIntent: ref.read(newTodoActionProvider),
            ReloadIntent: ref.read(reloadActionProvider),
            ToggleFocusIntent: ref.read(toggleFocusActionProvider),
          },
          child: child,
        ),
      ),
    );
  }
}

class _LoggingActionDispatcher extends ActionDispatcher {
  @override
  (bool, Object?) invokeActionIfEnabled(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    if (action is! DoNothingAction) {
      FirebaseAnalytics.instance.logEvent(
        name: AnalyticsEventName.tapShortcutKey.name,
        parameters: {
          'action': action.runtimeType.toString(),
        },
      );
    }

    return super.invokeActionIfEnabled(action, intent, context);
  }
}
