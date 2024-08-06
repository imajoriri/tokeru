import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/threads/threads.dart';

class ThreadView extends HookConsumerWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chat = ref.watch(selectedThreadProvider);
    // スレッドが選択されていない場合は何も表示しない。
    if (chat == null) {
      return const SizedBox.shrink();
    }

    final provider = threadsProvider(chatId: chat.id);
    final chats = ref.watch(provider);

    return Column(
      children: [
        const SizedBox(height: 8),
        ChatAndOgpListItem(
          message: chat.message,
        ),
        Expanded(
          child: chats.when(
            skipLoadingOnReload: true,
            data: (chats) {
              return ChatListItems.thread(
                threads: chats,
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
            focusNode: useFocusNode(),
            onSubmit: (message) {
              ref.read(provider.notifier).add(message: message);
            },
          ),
        ),
      ],
    );
  }
}
