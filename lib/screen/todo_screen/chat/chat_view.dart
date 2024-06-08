import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/chat/chat_controller.dart';
import 'package:quick_flutter/controller/selected_todo_item/selected_todo_item_controller.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoId = ref.watch(selectedTodoItemIdControllerProvider);
    if (todoId == null) {
      return const SizedBox();
    }

    final chats = ref.watch(chatControllerProvider(todoId));
    return chats.when(
      data: (chats) {
        return const _ChatListView();
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
    );
  }
}

class _ChatListView extends ConsumerWidget {
  const _ChatListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoId = ref.watch(selectedTodoItemIdControllerProvider);
    final chats = ref.watch(chatControllerProvider(todoId!)).requireValue;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: chats.length,
              shrinkWrap: true,
              reverse: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                final chat = chats[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  color: Colors.grey[100],
                  child: Text(chat.body),
                );
              },
            ),
          ),
          const TextField(
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
