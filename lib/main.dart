import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/todo/todo_controller.dart';
import 'package:quick_flutter/controller/todo_focus/todo_focus_controller.dart';
import 'package:quick_flutter/firebase_options.dart';
import 'package:quick_flutter/screen/text_field_screen/screen.dart';
import 'package:quick_flutter/systems/color.dart';
import 'package:quick_flutter/controller/url/url_controller.dart';
import 'package:quick_flutter/widget/actions/focus_down/focus_down_action.dart';
import 'package:quick_flutter/widget/actions/focus_up/focus_up_action.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      observers: [_AppObserver()],
      child: AppMaterialApp(
        home: _PlatformMenuBar(
          child: _CallbackShortcuts(
            child: TextFieldScreen(),
          ),
        ),
      ),
    ),
  );
}

/// [ShortcutActivatorType]に対応するアクションを提供するProvider
final _shorcutActionMapProvider =
    Provider.autoDispose<Map<ShortcutActivatorType, void Function()>>((ref) {
  return {
    // ピン
    ShortcutActivatorType.pinWindow: () async {
      ref.read(bookmarkControllerProvider.notifier).toggle();
    },
    // フォーカス中のTodoをチェックするショートカット
    ShortcutActivatorType.toggleDone: () async {
      final index =
          ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
      if (index != -1) {
        final todo = ref.read(todoControllerProvider).valueOrNull?[index];
        await ref
            .read(todoControllerProvider.notifier)
            .updateIsDone(todoId: todo!.id, isDone: !todo.isDone);

        // 削除した後に元いた場所にフォーカスを戻す
        ref.read(todoControllerProvider.notifier).deleteDoneWithDebounce(
              // ユーザーのタッチ操作ではないので、長く待つ必要もないので300ms
              milliseconds: 300,
              onDeleted: () {
                ref
                    .read(todoFocusControllerProvider.notifier)
                    .requestFocus(index);
              },
            );
      }
    },
    // escでウィンドウを閉じる
    ShortcutActivatorType.closeWindow: () async {
      final channel = ref.read(methodChannelProvider);
      channel.invokeMethod(AppMethodChannel.openOrClosePanel.name);
    },
    // Todoをひとつ上に移動する
    ShortcutActivatorType.moveUp: () async {
      final focusController = ref.read(todoFocusControllerProvider.notifier);
      final index = focusController.getFocusIndex();
      if (index != -1 && index != 0) {
        focusController.removeFocus();
        ref.read(todoControllerProvider.notifier).reorder(index, index - 1);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusController.requestFocus(index - 1);
        });
      }
    },
    // Todoをひとつ下に移動する
    ShortcutActivatorType.moveDown: () async {
      final focusController = ref.read(todoFocusControllerProvider.notifier);
      final index = focusController.getFocusIndex();
      if (index != -1 &&
          index != ref.read(todoControllerProvider).valueOrNull!.length - 1) {
        focusController.removeFocus();
        ref.read(todoControllerProvider.notifier).reorder(index, index + 1);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusController.requestFocus(index + 1);
        });
      }
    },
    // Todoの削除
    ShortcutActivatorType.deleteTodo: () async {
      final index =
          ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
      if (index == -1) return;

      final todoLength = ref.read(todoControllerProvider).valueOrNull!.length;
      // 最後の１つの場合、previousFoucsすると他のFocusに移動しちゃうため
      if (todoLength == 1) return;

      final todo = ref.read(todoControllerProvider).valueOrNull![index];
      await ref.read(todoControllerProvider.notifier).delete(todo);
      ref.read(todoFocusControllerProvider.notifier).requestFocus(index - 1);
    },
  };
});

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
      },
      child: Actions(
        actions: {
          NewTodoIntent: ref.read(newTodoActionProvider),
        },
        child: CallbackShortcuts(
          bindings: ref.watch(_shorcutActionMapProvider).map(
                (key, value) => MapEntry(
                  key.shortcutActivator,
                  value,
                ),
              ),
          child: FocusScope(
            autofocus: true,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// [PlatformMenuBar]の中でRefを使うためにラップしたWidgetクラス
class _PlatformMenuBar extends ConsumerWidget {
  const _PlatformMenuBar({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    final shortcutActionMap = ref.watch(_shorcutActionMapProvider);
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
                  onSelected: shortcutActionMap[ShortcutActivatorType.newTodo],
                ),
                // フォーカス中のTODOをチェックする
                PlatformMenuItem(
                  label: ShortcutActivatorType.toggleDone.label,
                  shortcut: ShortcutActivatorType.toggleDone.shortcutActivator,
                  onSelected:
                      shortcutActionMap[ShortcutActivatorType.toggleDone],
                ),
                // Todoを削除
                PlatformMenuItem(
                  label: ShortcutActivatorType.deleteTodo.label,
                  shortcut: ShortcutActivatorType.deleteTodo.shortcutActivator,
                  onSelected:
                      shortcutActionMap[ShortcutActivatorType.deleteTodo],
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                // 上へ移動
                PlatformMenuItem(
                  label: ShortcutActivatorType.moveUp.label,
                  shortcut: ShortcutActivatorType.moveUp.shortcutActivator,
                  onSelected: shortcutActionMap[ShortcutActivatorType.moveUp],
                ),
                // 下へ移動
                PlatformMenuItem(
                  label: ShortcutActivatorType.moveDown.label,
                  shortcut: ShortcutActivatorType.moveDown.shortcutActivator,
                  onSelected: shortcutActionMap[ShortcutActivatorType.moveDown],
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
                  onSelected:
                      shortcutActionMap[ShortcutActivatorType.pinWindow],
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
