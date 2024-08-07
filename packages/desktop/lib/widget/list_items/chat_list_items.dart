import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

class ChatListItems<T extends AppItem> extends ConsumerWidget {
  /// メインのチャットで表示するチャットのリスト。
  const ChatListItems.main({
    Key? key,
    required List<AppChatItem> chats,
    this.bottomSpace = 0,
    this.readTime,
    required this.onRead,
    required this.onThread,
    required this.onConvertTodo,
  })  : appItems = chats,
        super(key: key);

  /// スレッドで表示するチャットのリスト。
  const ChatListItems.thread({
    Key? key,
    required List<AppThreadItem> threads,
  })  : appItems = threads,
        onConvertTodo = null,
        onRead = null,
        onThread = null,
        bottomSpace = 0,
        readTime = null,
        super(key: key);

  final List<AppItem> appItems;

  final double bottomSpace;

  /// 最後に既読した時刻。
  ///
  /// 既読のDividerをこの時刻をもとに表示する。
  /// nullの場合は既読のDividerを表示しない。
  final DateTime? readTime;

  final void Function(T)? onRead;
  final void Function(T)? onThread;
  final void Function(T)? onConvertTodo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectionArea(
      child: ListView.builder(
        itemCount: appItems.length,
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, index) {
          final item = appItems[index];
          final isLast = index == 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TodoDivider(
                index: index,
                items: appItems,
                readTime: readTime,
              ),
              switch (item) {
                AppChatItem() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // スレッドの件数。0件の場合は表示しない。
                      if (item.threadCount != 0)
                        Text(
                          'Thread: ${item.threadCount}',
                          style: context.appTextTheme.labelMidium,
                        ),
                      ChatAndOgpListItem(
                        message: item.message,
                        onRead:
                            onRead != null ? () => onRead!(item as T) : null,
                        onThread: onThread != null
                            ? () => onThread!(item as T)
                            : null,
                        onConvertTodo: onConvertTodo != null
                            ? () => onConvertTodo!(item as T)
                            : null,
                      ),
                    ],
                  ),
                AppThreadItem() => ChatAndOgpListItem(
                    message: item.message,
                  ),
                _ => const SizedBox.shrink(),
              },
              if (isLast) const SizedBox(height: 16),
              if (isLast) _BottomSpace(bottomSpace: bottomSpace),
            ],
          );
        },
      ),
    );
  }
}

/// リストの最後に余白を追加するWidget。
class _BottomSpace extends StatelessWidget {
  const _BottomSpace({
    required this.bottomSpace,
  });

  final double bottomSpace;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOutExpo,
      child: SizedBox(height: bottomSpace),
    );
  }
}

class _TodoDivider extends StatelessWidget {
  const _TodoDivider({
    required this.items,
    required this.index,
    required this.readTime,
  });

  final int index;
  final List<AppItem> items;
  final DateTime? readTime;

  @override
  Widget build(BuildContext context) {
    final item = items[index];
    final next = items.firstWhereIndexedOrNull((i, _) => i == index + 1);
    // 次のAppItemが日付が変わるかどうか。
    final isNextDay = next != null && item.createdAt.day != next.createdAt.day;

    // 未読のラインを表示するかどうか。
    final isUnreadLine = readTime != null &&
        next != null &&
        item.createdAt.isAfter(readTime!) &&
        next.createdAt.isBefore(readTime!);
    return Column(
      children: [
        if (isNextDay)
          _DayDividerItem(
            year: item.createdAt.year,
            month: item.createdAt.month,
            day: item.createdAt.day,
          ),
        if (isUnreadLine) const _UnreadDivider(),
      ],
    );
  }
}

class _UnreadDivider extends StatelessWidget {
  const _UnreadDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.appColors.primary)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.appSpacing.small,
            vertical: context.appSpacing.smallX,
          ),
          child: Text(
            'New',
            style: context.appTextTheme.labelSmall
                .copyWith(color: context.appColors.primary),
          ),
        ),
      ],
    );
  }
}

/// 日付を跨ぐ際の区切り線。
class _DayDividerItem extends StatelessWidget {
  const _DayDividerItem({
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
        Expanded(child: Divider(color: context.appColors.outline)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.appColors.outline,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
          ),
        ),
        Expanded(child: Divider(color: context.appColors.outline)),
      ],
    );
  }
}
