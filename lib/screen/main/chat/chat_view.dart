import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todayAppItemControllerProvider;
    final appItems = ref.watch(provider);
    final textEditingController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                  child: ListView.separated(
                    itemCount: appItems.length,
                    shrinkWrap: true,
                    reverse: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemBuilder: (context, index) {
                      final appItem = appItems[index];
                      return switch (appItem) {
                        AppTodoItem(:final title) => Text(title),
                        AppChatItem(:final message) => Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  color: Colors.grey[100],
                                  child: SelectableText(message),
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }
}
