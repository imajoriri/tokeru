import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/screen/main/thread/thread_view.dart';
import 'package:tokeru_desktop/screen/main/chat/chat_view.dart';
import 'package:tokeru_desktop/screen/main/todo/todo_view.dart';
import 'package:tokeru_widgets/widgets.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.appColors.surface,
      body: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chat
          Expanded(
            child: Column(
              children: [
                Expanded(child: TodoView()),
                _Divider(
                  isVertical: false,
                ),
                Expanded(child: ChatView()),
              ],
            ),
          ),

          _Divider(),

          Expanded(child: ThreadView()),

          // Todoリスト
          // TODO: 不要だと感じたら削除する。
          // final showLoginButton =
          // ref.watch(userControllerProvider).valueOrNull?.isAnonymous ?? true;
          // Expanded(
          //   child: Column(
          //     children: [
          //       // login button
          //       Padding(
          //         padding: EdgeInsets.all(context.appSpacing.medium),
          //         child: AppTextButton.medium(
          //           onPressed: () {
          //             if (showLoginButton) {
          //               ref
          //                   .read(userControllerProvider.notifier)
          //                   .signInWithApple();
          //               return;
          //             }

          //             ref.read(userControllerProvider.notifier).signOut();
          //           },
          //           text: Text(showLoginButton ? 'Login' : 'Logout'),
          //         ),
          //       ),
          //       // todo list
          //       const Expanded(
          //         child: TodoView(),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({this.isVertical = true});

  /// Columnで使う場合はisVerticalをfalseにする。
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isVertical ? 3 : double.infinity,
      height: isVertical ? double.infinity : 3,
      margin: isVertical
          ? EdgeInsets.symmetric(vertical: context.appSpacing.small)
          : EdgeInsets.symmetric(horizontal: context.appSpacing.small),
      decoration: BoxDecoration(
        color: context.appColors.outline,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
