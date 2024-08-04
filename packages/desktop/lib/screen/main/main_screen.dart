import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/screen/main/thread/thread_view.dart';
import 'package:tokeru_model/controller/url/url_controller.dart';
import 'package:tokeru_desktop/screen/main/chat/chat_view.dart';
import 'package:tokeru_desktop/screen/main/todo/todo_view.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoginButton =
        ref.watch(userControllerProvider).valueOrNull?.isAnonymous ?? true;
    return Scaffold(
      backgroundColor: context.appColors.surface,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await launchUrl(UrlController.featureRequest.uri);
        },
        // 丸にする
        shape: CircleBorder(
          side: BorderSide(
            color: context.appColors.outline,
          ),
        ),
        elevation: 1,
        focusElevation: 1,
        highlightElevation: 1,
        hoverElevation: 1,
        // ripple effectをなくす
        splashColor: Colors.transparent,
        backgroundColor: context.appColors.surface,
        child: Icon(
          Icons.feedback_outlined,
          color: context.appColors.onSurfaceSubtle,
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          const Expanded(child: ChatView()),
          const _Divider(),

          const Expanded(child: ThreadView()),
          const _Divider(),

          // Todoリスト
          Expanded(
            child: Column(
              children: [
                // login button
                Padding(
                  padding: EdgeInsets.all(context.appSpacing.medium),
                  child: AppTextButton(
                    onPressed: () {
                      if (showLoginButton) {
                        ref
                            .read(userControllerProvider.notifier)
                            .signInWithApple();
                        return;
                      }

                      ref.read(userControllerProvider.notifier).signOut();
                    },
                    text: Text(showLoginButton ? 'Login' : 'Logout'),
                  ),
                ),
                // todo list
                const Expanded(
                  child: TodoView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.appSpacing.small),
      decoration: BoxDecoration(
        color: context.appColors.outline,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
