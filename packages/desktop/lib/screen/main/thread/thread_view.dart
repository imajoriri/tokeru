import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/list_item/chat_list_item.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/threads/threads.dart';

class ThreadView extends HookConsumerWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = threadsProvider(chatId: 'chatId');
    final chats = ref.watch(provider);

    return Column(
      children: [
        Expanded(
          child: chats.when(
            skipLoadingOnReload: true,
            data: (chats) {
              return ChatListItems(
                chats: chats,
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, _) {
              return Center(
                child: Text('Error: $error'),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ChatTextField(
            focusNode: FocusNode(),
            onSubmit: (message) {
              ref.read(provider.notifier).add(message: message);
            },
          ),
        ),
      ],
    );
  }
}
