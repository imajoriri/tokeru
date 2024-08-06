import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/chats/chats.dart';
import 'package:tokeru_model/controller/read/read_controller.dart';
import 'package:tokeru_model/controller/read_all/read_all_controller.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'chat_list.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Expanded(
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              _ChatList(),
              _ReadButton(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ChatTextField(
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
          child: ElevatedButton(
            onPressed: () => ref
                .read(readControllerProvider.notifier)
                .markAsRead(DateTime.now()),
            child: const Text('Mark as read'),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
    );
  }
}
