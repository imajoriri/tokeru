import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/actions/new_todo.dart/new_todo_action.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/shortcutkey.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_haptics/haptics.dart';
import 'package:tokeru_model/controller/chats/chats.dart';
import 'package:tokeru_model/controller/read/read_controller.dart';
import 'package:tokeru_model/controller/read_all/read_all_controller.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/todos/todos.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'chat_list.dart';
part 'todo_modal.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _ChatList(),
              _ReadButton(),
              // TODO: TodoModal。不要だと感じたら削除する。
              // Positioned(
              //   top: 24,
              //   left: 16,
              //   right: 16,
              //   child: _TodoModal(),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ChatTextField.chat(
            focusNode: chatFocusNode,
            onSubmit: (message) {
              ref.read(chatsProvider.notifier).addChat(message: message);
              FirebaseAnalytics.instance.logEvent(
                name: AnalyticsEventName.addChat.name,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReadButton extends ConsumerWidget {
  const _ReadButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readAll = ref.watch(readAllProvider);
    return readAll.when(
      skipLoadingOnReload: true,
      data: (value) {
        if (value) {
          return const SizedBox.shrink();
        }
        return Positioned(
          bottom: context.appSpacing.small,
          child: AppButton(
            onPressed: () => ref
                .read(readControllerProvider.notifier)
                .markAsRead(DateTime.now()),
            style: AppButtonStyle(
              contentColor: context.appColors.onPrimary,
              backgroundColor: context.appColors.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    // icon
                    WidgetSpan(
                      child: Icon(
                        AppIcons.read,
                        size: 16,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 4),
                    ),
                    TextSpan(
                      text: 'Mark all as read',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
    );
  }
}
