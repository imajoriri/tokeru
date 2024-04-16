import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:logger/logger.dart';
import 'package:quick_flutter/controller/bookmark/bookmark_controller.dart';
import 'package:quick_flutter/controller/hot_key/hot_key_controller.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/screen_type/screen_type_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/model/analytics_event/analytics_event_name.dart';
import 'package:quick_flutter/screen/settings/settings_screen.dart';
import 'package:quick_flutter/screen/todo_screen/todo_screen.dart';
import 'package:quick_flutter/systems/color.dart';
import 'package:quick_flutter/controller/url/url_controller.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/actions/close_window/close_window_action.dart';
import 'package:quick_flutter/widget/actions/delete_todo/delete_todo_action.dart';
import 'package:quick_flutter/widget/actions/focus_down/focus_down_action.dart';
import 'package:quick_flutter/widget/actions/focus_up/focus_up_action.dart';
import 'package:quick_flutter/widget/actions/move_down_todo/move_down_todo_action.dart';
import 'package:quick_flutter/widget/actions/move_up_todo/move_up_todo_action.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/actions/new_todo_below/new_todo_below_action.dart';
import 'package:quick_flutter/widget/actions/pin_window/pin_window_action.dart';
import 'package:quick_flutter/widget/actions/toggle_todo_done/toggle_todo_done_action.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';

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
          child: _PlatformMenuBar(
            child: Consumer(
              builder: (context, ref, child) {
                final largeWindowKey = GlobalKey();
                final channel = ref.watch(methodChannelProvider);
                final bookmark = ref.watch(bookmarkControllerProvider);
                ref.watch(hotKeyControllerProvider);

                channel.setMethodCallHandler((call) async {
                  switch (call.method) {
                    case 'inactive':
                      if (!bookmark) {
                        channel.invokeMethod(
                          AppMethodChannel.closeWindow.name,
                        );
                      }
                      break;
                  }
                  return null;
                });

                return Material(
                  child: SingleChildScrollView(
                    child: NotificationListener<SizeChangedLayoutNotification>(
                      onNotification: (notification) {
                        // サイズが変更されたことを検知した時の処理
                        ref.read(methodChannelProvider).invokeMethod(
                          AppMethodChannel.setFrameSize.name,
                          {
                            "height":
                                largeWindowKey.currentContext?.size?.height,
                          },
                        );
                        return true;
                      },
                      child: SizeChangedLayoutNotifier(
                        child: _LargeWindow(
                          key: largeWindowKey,
                          onBuildCallback: () {
                            ref.read(methodChannelProvider).invokeMethod(
                              AppMethodChannel.setFrameSize.name,
                              {
                                "height":
                                    largeWindowKey.currentContext?.size?.height,
                              },
                            );
                          },
                        ),
                      ),
                    ),
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
  const _LargeWindow({Key? key, this.onBuildCallback}) : super(key: key);

  /// ビルド後に呼ばれるコールバック
  final Function? onBuildCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenType = ref.watch(screenTypeControllerProvider);
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onBuildCallback?.call();
        });
        return null;
      },
      const [],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 4, right: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(),
          switch (screenType) {
            ScreenType.todo => const TodoScreen(),
            ScreenType.settings => const SettingsScreen(),
          },
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final bookmark = ref.watch(bookmarkControllerProvider);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                tooltip: ShortcutActivatorType.closeWindow.longLabel,
                onPressed: () {
                  channel.invokeMethod(
                    AppMethodChannel.openOrClosePanel.name,
                  );
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),

        // 右がわのアイコン
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                onPressed: () {
                  ref.read(screenTypeControllerProvider.notifier).screenType =
                      ScreenType.settings;
                },
                icon: const Icon(Icons.keyboard_command_key_sharp),
              ),
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
                onPressed: () {
                  ref.read(bookmarkControllerProvider.notifier).toggle();
                },
                tooltip: ShortcutActivatorType.pinWindow.longLabel,
                icon: Icon(
                  bookmark ? Icons.push_pin : Icons.push_pin_outlined,
                ),
                color: bookmark
                    ? context.colorScheme.primary
                    : context.colorScheme.secondary,
              ),
              IconButton(
                focusNode: FocusNode(skipTraversal: true),
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
        ShortcutActivatorType.pinWindow.shortcutActivator:
            const PinWindowIntent(),
        ShortcutActivatorType.toggleDone.shortcutActivator:
            const ToggleTodoDoneIntent(),
        ShortcutActivatorType.closeWindow.shortcutActivator:
            const CloseWindowIntent(),
        ShortcutActivatorType.moveUp.shortcutActivator:
            const MoveUpTodoIntent(),
        ShortcutActivatorType.moveDown.shortcutActivator:
            const MoveDownTodoIntent(),
        ShortcutActivatorType.deleteTodo.shortcutActivator:
            const DeleteTodoIntent(),
      },
      child: Actions(
        dispatcher: _LoggingActionDispatcher(),
        actions: {
          NewTodoIntent: ref.read(newTodoActionProvider),
          PinWindowIntent: ref.read(pinWindowActionProvider),
          CloseWindowIntent: ref.read(closeWindowActionProvider),
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

/// [PlatformMenuBar]の中でRefを使うためにラップしたWidgetクラス
class _PlatformMenuBar extends ConsumerWidget {
  const _PlatformMenuBar({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: "",
          menus: [
            const PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'About Tokeru(WIP)',
                ),
              ],
            ),
            const PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Settings...(WIP)',
                ),
                PlatformMenuItem(
                  label: 'Share Tokeru(WIP)',
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Show or Hide Tokeru',
                  shortcut:
                      ShortcutActivatorType.toggleWindow.shortcutActivator,
                  onSelected: () {
                    channel.invokeMethod(
                      AppMethodChannel.openOrClosePanel.name,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // todo
        PlatformMenu(
          label: "Todo",
          menus: [
            PlatformMenuItemGroup(
              members: [
                // 新規TODO
                PlatformMenuItem(
                  label: ShortcutActivatorType.newTodo.label,
                  shortcut: ShortcutActivatorType.newTodo.shortcutActivator,
                  onSelected: () {
                    Actions.maybeInvoke<NewTodoIntent>(
                      context,
                      const NewTodoIntent(),
                    );
                  },
                ),
                // フォーカス中のTODOをチェックする
                PlatformMenuItem(
                  label: ShortcutActivatorType.toggleDone.label,
                  shortcut: ShortcutActivatorType.toggleDone.shortcutActivator,
                  onSelected: () {
                    Actions.maybeInvoke<ToggleTodoDoneIntent>(
                      context,
                      const ToggleTodoDoneIntent(),
                    );
                  },
                ),
                // Todoを削除
                PlatformMenuItem(
                  label: ShortcutActivatorType.deleteTodo.label,
                  shortcut: ShortcutActivatorType.deleteTodo.shortcutActivator,
                  onSelected: () {
                    Actions.maybeInvoke<DeleteTodoIntent>(
                      context,
                      const DeleteTodoIntent(),
                    );
                  },
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                // 上へ移動
                PlatformMenuItem(
                  label: ShortcutActivatorType.moveUp.label,
                  shortcut: ShortcutActivatorType.moveUp.shortcutActivator,
                  onSelected: () => Actions.maybeInvoke<MoveUpTodoIntent>(
                    context,
                    const MoveUpTodoIntent(),
                  ),
                ),
                // 下へ移動
                PlatformMenuItem(
                  label: ShortcutActivatorType.moveDown.label,
                  shortcut: ShortcutActivatorType.moveDown.shortcutActivator,
                  onSelected: () {
                    Actions.maybeInvoke<MoveDownTodoIntent>(
                      context,
                      const MoveDownTodoIntent(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // window
        PlatformMenu(
          label: "Window",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: ShortcutActivatorType.pinWindow.label,
                  onSelected: () {
                    Actions.maybeInvoke<PinWindowIntent>(
                      context,
                      const PinWindowIntent(),
                    );
                  },
                  shortcut: ShortcutActivatorType.pinWindow.shortcutActivator,
                ),
              ],
            ),
          ],
        ),

        // contact developer
        PlatformMenu(
          label: "You are welcome to contact me!👋",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Thank you for using Tokeru!😊',
                  onSelected: () async {
                    await UrlController.developerXAccount.launch();
                  },
                ),
                PlatformMenuItem(
                  label: 'I would like to hear your feedback!',
                  onSelected: () async {
                    await UrlController.developerXAccount.launch();
                  },
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: '📩 Follow on X(Twitter)',
                  onSelected: () async {
                    await UrlController.developerXAccount.launch();
                  },
                ),
                PlatformMenuItem(
                  label: '💡 Got an idea for a feature',
                  onSelected: () async {
                    await UrlController.featureRequest.launch();
                  },
                ),
                PlatformMenuItem(
                  label: '📝 Found a bug',
                  onSelected: () async {
                    await UrlController.bugReport.launch();
                  },
                ),
                PlatformMenuItem(
                  label: '🧑‍💻 Tokeru repository is public',
                  onSelected: () async {
                    await UrlController.tokeruRepository.launch();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      child: child,
    );
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.seed,
              outline: AppColor.outline,
              outlineVariant: AppColor.outlineVariant,
              shadow: AppColor.shadow,
            ),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
}
