part of 'chat_view.dart';

class _ChatList extends ConsumerWidget {
  const _ChatList({
    required this.appItems,
  });

  final AsyncValue<List<AppItem>> appItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return appItems.when(
      skipLoadingOnReload: true,
      data: (appItems) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 300) {
              ref.read(todayAppItemControllerProvider.notifier).fetchNext();
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
                  Builder(
                    builder: (context) {
                      if (index == appItems.length - 1) {
                        return const SizedBox.shrink();
                      }
                      // ignore: unnecessary_cast
                      final nextAppItem = appItems[index + 1] as AppItem?;
                      // 次のAppItemが日付が変わるかどうか。
                      final isNextDay = nextAppItem != null &&
                          appItem.createdAt.day != nextAppItem.createdAt.day;
                      if (isNextDay) {
                        return _DayDividerItem(
                          year: appItem.createdAt.year,
                          month: appItem.createdAt.month,
                          day: appItem.createdAt.day,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
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
                  if (isLast) const SizedBox(height: 16),
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
