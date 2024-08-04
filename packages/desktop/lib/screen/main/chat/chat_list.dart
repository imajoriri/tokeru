part of 'chat_view.dart';

class _ChatList extends HookConsumerWidget {
  const _ChatList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appItems = ref.watch(chatsProvider());

    return appItems.when(
      skipLoadingOnReload: true,
      data: (appItems) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter < 300) {
              ref.read(chatsProvider().notifier).fetchNext();
            }
            return false;
          },
          child: SelectionArea(
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
                    _ChatListItemChat(appItem: appItem),
                    if (isLast) const _BottomSpace(),
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
    );
  }
}

/// リストの最後に余白を追加するWidget。
class _BottomSpace extends ConsumerWidget {
  const _BottomSpace();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readAll = ref.watch(readAllProvider).valueOrNull == true;
    return Column(
      children: [
        const SizedBox(height: 16),
        // 既読ボタンがある時はテキストと被らないように、
        // 余白を追加する。
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOutExpo,
          child: SizedBox(height: readAll ? 0 : 32),
        ),
      ],
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
    final item = ref.watch(chatsProvider()).valueOrNull?[index] as AppItem;
    final next = ref
        .watch(chatsProvider())
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

class _ChatListItemChat extends ConsumerWidget {
  const _ChatListItemChat({
    required this.appItem,
  });

  final AppChatItem appItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = getLinks(text: appItem.message);
    return ChatListItem.chat(
      text: appItem.message,
      launchUrl: (link) async {
        if (!await launchUrl(link)) {
          throw Exception('Could not launch ${link.toString()}');
        }
      },
      onRead: () {
        ref.read(readControllerProvider.notifier).markAsReadAsChat(appItem);
      },
      bottomWidget: SelectionContainer.disabled(
        child: links.isEmpty
            ? const SizedBox.shrink()
            : ListView.separated(
                padding:
                    EdgeInsets.symmetric(vertical: context.appSpacing.small),
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
                          title: ogp.title,
                          description: ogp.description,
                          imageUrl: ogp.imageUrl,
                          url: uri.toString(),
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
