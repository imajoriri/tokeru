import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/controller/url/url_controller.dart';
import 'package:tokeru_desktop/utils/method_channel.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/actions/reload/reload_action.dart';
import 'package:tokeru_desktop/widget/shortcutkey.dart';

/// [PlatformMenuBar]の中でRefを使うためにラップしたWidgetクラス
class AppPlatformMenuBar extends ConsumerWidget {
  const AppPlatformMenuBar({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    mainMethodChannel.quit();
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
                ),
                // Todoを削除
                PlatformMenuItem(
                  label: ShortcutActivatorType.deleteTodo.label,
                  shortcut: ShortcutActivatorType.deleteTodo.shortcutActivator,
                  onSelected: () {},
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                // 上へ移動
                PlatformMenuItem(
                  label: ShortcutActivatorType.moveUp.label,
                  shortcut: ShortcutActivatorType.moveUp.shortcutActivator,
                  onSelected: () {},
                ),
                // 下へ移動
                PlatformMenuItem(
                  label: ShortcutActivatorType.moveDown.label,
                  shortcut: ShortcutActivatorType.moveDown.shortcutActivator,
                  onSelected: () {},
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
