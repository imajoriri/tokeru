import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/list_item/chat_list_item.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todayAppItemControllerProvider;
    final appItems = ref.watch(provider);
    final textEditingController = useTextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        appItems.when(
          data: (appItems) {
            return Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.extentAfter < 300) {
                    ref
                        .read(todayAppItemControllerProvider.notifier)
                        .fetchNext();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: appItems.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final appItem = appItems[index];
                    return switch (appItem) {
                      AppTodoItem() => ChatListItem.todo(todo: appItem),
                      AppChatItem() => ChatListItem.chat(chat: appItem),
                      AppDividerItem() => throw UnimplementedError(),
                    };
                  },
                ),
              ),
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
        CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.enter, meta: true): () {
              if (textEditingController.text.isEmpty) return;
              ref
                  .read(provider.notifier)
                  .addChat(message: textEditingController.text);
              textEditingController.clear();
            },
          },
          child: TextField(
            controller: textEditingController,
            maxLines: null,
            focusNode: chatFocusNode,
          ),
        ),
      ],
    );
  }
}
