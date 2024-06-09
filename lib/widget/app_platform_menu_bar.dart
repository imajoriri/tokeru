import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:quick_flutter/controller/url/url_controller.dart';
import 'package:quick_flutter/widget/actions/delete_todo/delete_todo_action.dart';
import 'package:quick_flutter/widget/actions/move_down_todo/move_down_todo_action.dart';
import 'package:quick_flutter/widget/actions/move_up_todo/move_up_todo_action.dart';
import 'package:quick_flutter/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:quick_flutter/widget/actions/reload/reload_action.dart';
import 'package:quick_flutter/widget/actions/select_todo_down/select_todo_down_action.dart';
import 'package:quick_flutter/widget/actions/select_todo_up/select_todo_up_action.dart';
import 'package:quick_flutter/widget/actions/toggle_todo_done/toggle_todo_done_action.dart';
import 'package:quick_flutter/widget/shortcutkey.dart';

/// [PlatformMenuBar]の中でRefを使うためにラップしたWidgetクラス
class AppPlatformMenuBar extends ConsumerWidget {
  const AppPlatformMenuBar({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(methodChannelProvider);
    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: "",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: 'Quit Tokeru',
                  shortcut: ShortcutActivatorType.quit.shortcutActivator,
                  onSelected: () {
                    channel.invokeMethod(
                      AppMethodChannel.quit.name,
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
          label: "Chat",
          menus: [
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: ShortcutActivatorType.selectTodoUp.label,
                  onSelected: () {
                    Actions.maybeInvoke<SelectTodoUpIntent>(
                      context,
                      const SelectTodoUpIntent(),
                    );
                  },
                  shortcut:
                      ShortcutActivatorType.selectTodoUp.shortcutActivator,
                ),
                PlatformMenuItem(
                  label: ShortcutActivatorType.selectTodoDown.label,
                  onSelected: () {
                    Actions.maybeInvoke<SelectTodoDownIntent>(
                      context,
                      const SelectTodoDownIntent(),
                    );
                  },
                  shortcut:
                      ShortcutActivatorType.selectTodoDown.shortcutActivator,
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
                  label: ShortcutActivatorType.reload.label,
                  onSelected: () {
                    Actions.maybeInvoke<ReloadIntent>(
                      context,
                      const ReloadIntent(),
                    );
                  },
                  shortcut: ShortcutActivatorType.reload.shortcutActivator,
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
