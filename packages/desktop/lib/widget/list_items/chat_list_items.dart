import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tokeru_desktop/widget/chat_and_ogp_list_item.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

class ChatListItems<T extends AppItem> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SelectionArea(
      child: ListView.builder(
        itemCount: appItems.length,
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, index) {
          final item = appItems[index];
          final isLast = index == 0;

          final next =
              appItems.firstWhereIndexedOrNull((i, _) => i == index + 1);
          // 現在時刻を表示するかどうか。直前のアイテムのの作成時刻から10分以上経過している場合は表示する。
          final isShowCreatedDate = next != null &&
              item.createdAt
                  .isBefore(next.createdAt.add(const Duration(minutes: 10)));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Divider(
                item: appItems[index],
                next: next,
                readTime: readTime,
              ),
              switch (item) {
                AppChatItem(:final createdAt) => ChatAndOgpListItem.chat(
                    message: item.message,
                    createdAt: createdAt,
                    onRead: onRead != null ? () => onRead!(item as T) : null,
                    onThread:
                        onThread != null ? () => onThread!(item as T) : null,
                    onConvertTodo: onConvertTodo != null
                        ? () => onConvertTodo!(item as T)
                        : null,
                    threadCount: item.threadCount,
                    isAfter10Minutes: isShowCreatedDate,
                  ),
                AppThreadItem(:final createdAt) => ChatAndOgpListItem.thread(
                    message: item.message,
                    createdAt: createdAt,
                    isAfter10Minutes: isShowCreatedDate,
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

class _Divider extends StatelessWidget {
  const _Divider({
    required this.item,
    required this.next,
    required this.readTime,
  });

  final AppItem item;
  final AppItem? next;
  final DateTime? readTime;

  @override
  Widget build(BuildContext context) {
    // 次のAppItemが日付が変わるかどうか。
    final isNextDay = next != null && item.createdAt.day != next!.createdAt.day;

    // 未読のラインを表示するかどうか。
    final isUnreadLine = readTime != null &&
        next != null &&
        item.createdAt.isAfter(readTime!) &&
        next!.createdAt.isBefore(readTime!);
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

/// 「New」マークの未読のDivider。
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(
            text,
            style: context.appTextTheme.labelSmall,
          ),
        ),
        Expanded(child: Divider(color: context.appColors.outline)),
      ],
    );
  }
}
