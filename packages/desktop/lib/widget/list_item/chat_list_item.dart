import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/ogp_controller/ogp_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatListItems extends StatelessWidget {
  const ChatListItems({
    Key? key,
    required this.chats,
    this.bottomSpace = 0,
    this.readTime,
    this.onRead,
    this.onThread,
  }) : super(key: key);

  final List<AppChatItem> chats;

  final double bottomSpace;

  /// 最後に既読した時刻。
  ///
  /// 既読のDividerをこの時刻をもとに表示する。
  /// nullの場合は既読のDividerを表示しない。
  final DateTime? readTime;

  /// チャットの既読ボタンを押した時のコールバック。
  final void Function(AppChatItem chat)? onRead;

  /// スレッドを押した時のコールバック。
  final void Function(AppChatItem chat)? onThread;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: ListView.builder(
        itemCount: chats.length,
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, index) {
          final chat = chats[index];
          final isLast = index == 0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TodoDivider(
                index: index,
                chats: chats,
                readTime: readTime,
              ),
              _ChatListItemChat(
                chat: chat,
                onRead: onRead,
                onThread: onThread,
              ),
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
    required this.chats,
    required this.index,
    required this.readTime,
  });

  final int index;
  final List<AppChatItem> chats;
  final DateTime? readTime;

  @override
  Widget build(BuildContext context) {
    final item = chats[index];
    final next = chats.firstWhereIndexedOrNull((i, _) => i == index + 1);
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

class _ChatListItemChat extends ConsumerWidget {
  const _ChatListItemChat({
    required this.chat,
    required this.onRead,
    required this.onThread,
  });

  final AppChatItem chat;
  final void Function(AppChatItem chat)? onRead;
  final void Function(AppChatItem chat)? onThread;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = getLinks(text: chat.message);
    return ChatListItem.chat(
      text: chat.message,
      launchUrl: (link) async {
        if (!await launchUrl(link)) {
          throw Exception('Could not launch ${link.toString()}');
        }
      },
      onRead: onRead != null ? () => onRead?.call(chat) : null,
      onThread: onThread != null ? () => onThread?.call(chat) : null,
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