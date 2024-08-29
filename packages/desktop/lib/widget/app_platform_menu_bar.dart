import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/url/url_controller.dart';
import 'package:tokeru_desktop/utils/method_channel.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/shortcutkey.dart';
import 'package:url_launcher/url_launcher.dart';

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
                // PlatformMenuItem(
                //   label: 'Login',
                //   onSelected: () {
                //     ref.read(userControllerProvider.notifier).signInWithApple();
                //   },
                // ),
                // PlatformMenuItem(
                //   label: 'Logout',
                //   onSelected: () {
                //     ref.read(userControllerProvider.notifier).signOut();
                //   },
                // ),
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
                    await launchUrl(UrlController.developerXAccount.uri);
                  },
                ),
                PlatformMenuItem(
                  label: 'I would like to hear your feedback!',
                  onSelected: () async {
                    await launchUrl(UrlController.developerXAccount.uri);
                  },
                ),
              ],
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformMenuItem(
                  label: '📩 Follow on X(Twitter)',
                  onSelected: () async {
                    await launchUrl(UrlController.developerXAccount.uri);
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
