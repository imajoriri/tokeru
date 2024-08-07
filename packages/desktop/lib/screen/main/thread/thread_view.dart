import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/controller/threads/threads.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';

class ThreadView extends HookConsumerWidget {
  const ThreadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(selectedThreadProvider);
    // スレッドが選択されていない場合は何も表示しない。
    if (item == null) {
      return const SizedBox.shrink();
    }

    final appItems = ref.watch(threadsProvider);

    return Column(
      children: [
        const SizedBox(height: 8),
        switch (item) {
          AppChatItem() => ChatAndOgpListItem(
              message: item.message,
            ),
          AppTodoItem() => Text(item.title),
          _ => throw UnimplementedError(),
        },
        Expanded(
          child: appItems.when(
            skipLoadingOnReload: true,
            data: (appItems) {
              return ChatListItems.thread(
                threads: appItems,
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
              ref.read(threadsProvider.notifier).add(message: message);
            },
          ),
        ),
      ],
    );
  }
}
