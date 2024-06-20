import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/today_app_item/today_app_item_controller.dart';
import 'package:quick_flutter/controller/todo_update/todo_update_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/widget/focus_nodes.dart';
import 'package:quick_flutter/widget/list_item/chat_list_item.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

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
                    // ignore: unnecessary_cast
                    final nextAppItem = appItems[index + 1] as AppItem?;
                    // 次のAppItemが日付が変わるかどうか。
                    final isNextDay = nextAppItem != null &&
                        appItem.createdAt.day != nextAppItem.createdAt.day;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isNextDay)
                          DayDividerItem(
                            year: appItem.createdAt.year,
                            month: appItem.createdAt.month,
                            day: appItem.createdAt.day,
                          ),
                        switch (appItem) {
                          AppTodoItem() => ChatListItem.todo(
                              todo: appItem,
                              onChangedCheck: (value) {
                                ref.read(
                                  todoUpdateControllerProvider(
                                    todo: appItem.copyWith(
                                        isDone: value ?? false),
                                  ).future,
                                );
                              },
                            ),
                          AppChatItem() => ChatListItem.chat(chat: appItem),
                          AppDividerItem() => throw UnimplementedError(),
                        },
                      ],
                    );
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

/// 日付を跨ぐ際の区切り線。
class DayDividerItem extends StatelessWidget {
  const DayDividerItem({
    super.key,
    required this.year,
    required this.month,
    required this.day,
  });
  // year
  final int year;
  // month
  final int month;
  // day
  final int day;

  @override
  Widget build(BuildContext context) {
    final isToday = DateTime.now().year == year &&
        DateTime.now().month == month &&
        DateTime.now().day == day;

    final text = isToday ? 'Today' : '$month/$day';
    return Row(
      children: [
        Expanded(child: Divider(color: context.appColors.borderDefault)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.appColors.borderDefault,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
          ),
        ),
        Expanded(child: Divider(color: context.appColors.borderDefault)),
      ],
    );
  }
}
