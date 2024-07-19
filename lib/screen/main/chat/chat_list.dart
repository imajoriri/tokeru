part of 'chat_view.dart';

class _ChatList extends ConsumerWidget {
  const _ChatList({
    required this.appItems,
  });

  final AsyncValue<List<AppItem>> appItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readAll = ref.watch(readAllProvider).valueOrNull == true;
    return appItems.when(
      skipLoadingOnReload: true,
      data: (appItems) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 300) {
              ref.read(appItemControllerProvider.notifier).fetchNext();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: appItems.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              final appItem = appItems[index];
              final isLast = index == 0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TodoDivider(index: index),
                  switch (appItem) {
                    AppTodoItem() => ChatListItem.todo(
                        todo: appItem,
                        onChangedCheck: (value) {
                          ref.read(
                            todoUpdateControllerProvider(
                              todo: appItem.copyWith(
                                isDone: value ?? false,
                              ),
                            ).future,
                          );
                        },
                      ),
                    AppChatItem() => _ChatListItemChat(appItem: appItem),
                    AppDividerItem() => throw UnimplementedError(),
                  },
                  if (isLast) ...[
                    const SizedBox(height: 16),
                    // 既読ボタンがある時はテキストと被らないように、
                    // 余白を追加する。
                    AnimatedSize(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeInOutExpo,
                      child: SizedBox(height: readAll ? 0 : 32),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
      loading: () {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: CupertinoActivityIndicator(),
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

class _TodoDivider extends ConsumerWidget {
  const _TodoDivider({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item =
        ref.watch(appItemControllerProvider).valueOrNull?[index] as AppItem;
    final next = ref
        .watch(appItemControllerProvider)
        .valueOrNull
        ?.firstWhereIndexedOrNull((i, _) => i == index + 1);
    // 次のAppItemが日付が変わるかどうか。
    final isNextDay = next != null && item.createdAt.day != next.createdAt.day;

    final readTime = ref.watch(readControllerProvider).valueOrNull;
    // 未読のラインを表示するかどうか。
    final isUnreadLine = readTime != null &&
        next != null &&
        item.createdAt.isAfter(readTime) &&
        next.createdAt.isBefore(readTime);
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
        Expanded(child: Divider(color: context.appColors.borderDefault)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: const Text(
            'New',
          ),
        ),
      ],
    );
  }
}

class _ChatListItemChat extends ConsumerWidget {
  const _ChatListItemChat({
    required this.appItem,
  });

  final AppChatItem appItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = appItem.links;
    return ChatListItem.chat(
      chat: appItem,
      bottomWidget: links.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final uri = links[index];
                final asyncValue =
                    ref.watch(ogpControllerProvider(url: uri.toString()));
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: asyncValue.when(
                    data: (ogp) {
                      return UrlPreviewCard(
                        key: ValueKey(uri.toString()),
                        ogp: ogp,
                        onTap: () async {
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                      );
                    },
                    loading: () {
                      return const UrlPreviewCard.loading();
                    },
                    error: (error, _) {
                      return const SizedBox.shrink();
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: context.appSpacing.small);
              },
              itemCount: links.length,
            ),
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
