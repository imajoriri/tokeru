import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:logger/logger.dart';
import 'package:quick_flutter/controller/hot_key/hot_key_controller.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/refresh/refresh_controller.dart';
import 'package:quick_flutter/controller/screen_type/screen_type_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/screen/settings/settings_screen.dart';
import 'package:quick_flutter/screen/todo_screen/todo_screen.dart';
import 'package:quick_flutter/widget/actions/delete_todo/delete_todo_action.dart';
import 'package:quick_flutter/widget/actions/focus_down/focus_down_action.dart';
import 'package:quick_flutter/widget/actions/focus_up/focus_up_action.dart';
import 'package:quick_flutter/widget/actions/move_down_todo/move_down_todo_action.dart';
import 'package:quick_flutter/widget/actions/move_up_todo/move_up_todo_action.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/actions/new_todo_below/new_todo_below_action.dart';
import 'package:quick_flutter/widget/actions/reload/reload_action.dart';
import 'package:quick_flutter/widget/actions/select_todo_down/select_todo_down_action.dart';
import 'package:quick_flutter/widget/actions/select_todo_up/select_todo_up_action.dart';
import 'package:quick_flutter/widget/actions/toggle_focus/toggle_focus_action.dart';
import 'package:quick_flutter/widget/actions/toggle_todo_done/toggle_todo_done_action.dart';
import 'package:quick_flutter/widget/app_platform_menu_bar.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await hotKeyManager.unregisterAll();

  runApp(
    ProviderScope(
      observers: [_AppObserver()],
      child: AppMaterialApp(
        home: _CallbackShortcuts(
          child: AppPlatformMenuBar(
            child: Consumer(
              builder: (context, ref, child) {
                final largeWindowKey = GlobalKey();
                final channel = ref.watch(methodChannelProvider);
                ref.watch(hotKeyControllerProvider);

                channel.setMethodCallHandler((call) async {
                  switch (call.method) {
                    case 'inactive':
                      break;
                    case 'active':
                      // 更新が昨日以前の場合は、データを更新する
                      if (ref
                          .read(refreshControllerProvider.notifier)
                          .isPast()) {
                        ref.invalidate(refreshControllerProvider);
                      }
                  }
                  return null;
                });

                return Material(
                  color: context.appColors.backgroundDefault,
                  child: _LargeWindow(
                    key: largeWindowKey,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

class _LargeWindow extends HookConsumerWidget {
  const _LargeWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenType = ref.watch(screenTypeControllerProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 4, right: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(),
          Expanded(
            child: switch (screenType) {
              ScreenType.todo => const TodoScreen(),
              ScreenType.settings => const SettingsScreen(),
            },
          ),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        // 右がわのアイコン
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                tooltip: ShortcutActivatorType.newTodo.longLabel,
                onPressed: () async {
                  await ref.read(todoControllerProvider.notifier).add(0);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref
                        .read(todoFocusControllerProvider.notifier)
                        .requestFocus(0);
                  });

                  await FirebaseAnalytics.instance.logEvent(
                    name: AnalyticsEventName.addTodo.name,
                  );
                },
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// [CallbackShortcuts]の中でRefを使うためにラップしたWidgetクラス
class _CallbackShortcuts extends ConsumerWidget {
  const _CallbackShortcuts({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shortcuts(
      shortcuts: {
        ShortcutActivatorType.focusUp.shortcutActivator: const FocusUpIntent(),
        ShortcutActivatorType.focusDown.shortcutActivator:
            const FocusDownIntent(),
        ShortcutActivatorType.newTodo.shortcutActivator: const NewTodoIntent(),
        ShortcutActivatorType.newTodoBelow.shortcutActivator:
            const NewTodoBelowIntent(),
        ShortcutActivatorType.toggleDone.shortcutActivator:
            const ToggleTodoDoneIntent(),
        ShortcutActivatorType.moveUp.shortcutActivator:
            const MoveUpTodoIntent(),
        ShortcutActivatorType.moveDown.shortcutActivator:
            const MoveDownTodoIntent(),
        ShortcutActivatorType.deleteTodo.shortcutActivator:
            const DeleteTodoIntent(),
        ShortcutActivatorType.reload.shortcutActivator: const ReloadIntent(),
        ShortcutActivatorType.switchFocusChat.shortcutActivator:
            const ToggleFocusIntent(),
        ShortcutActivatorType.switchFocusTodo.shortcutActivator:
            const ToggleFocusIntent(),
        ShortcutActivatorType.selectTodoDown.shortcutActivator:
            const SelectTodoDownIntent(),
        ShortcutActivatorType.selectTodoUp.shortcutActivator:
            const SelectTodoUpIntent(),
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

class _AppObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is AsyncError) {
      final logger = Logger();
      logger.e(
        newValue.error.toString(),
        error: newValue.error,
        stackTrace: newValue.stackTrace,
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final logger = Logger();
    logger.e(
      error,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

class AppMaterialApp extends MaterialApp {
  AppMaterialApp({
    Key? key,
    required Widget home,
  }) : super(
          key: key,
          home: home,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
}
