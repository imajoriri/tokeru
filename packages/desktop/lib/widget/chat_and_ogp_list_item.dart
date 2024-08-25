import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/ogp_controller/ogp_controller.dart';
import 'package:tokeru_widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatAndOgpListItem extends ConsumerWidget {
  const ChatAndOgpListItem.chat({
    super.key,
    required this.message,
    required this.createdAt,
    this.onRead,
    this.onThread,
    this.onConvertTodo,
    this.threadCount = 0,

    /// 直前の投稿から10分以上経過しているかどうか。
    required bool isAfter10Minutes,
  }) : createdDateType = isAfter10Minutes
            ? ChatCreatedDateType.hover
            : ChatCreatedDateType.always;

  const ChatAndOgpListItem.thread({
    super.key,
    required this.message,
    required this.createdAt,

    /// 直前の投稿から10分以上経過しているかどうか。
    required bool isAfter10Minutes,
  })  : onRead = null,
        onThread = null,
        onConvertTodo = null,
        threadCount = 0,
        createdDateType = isAfter10Minutes
            ? ChatCreatedDateType.hover
            : ChatCreatedDateType.always;

  const ChatAndOgpListItem.aiComment({
    super.key,
    required String userMessage,
    required String aiMessage,
    required this.createdAt,
  })  : message = '$userMessage\n$aiMessage',
        onRead = null,
        onThread = null,
        onConvertTodo = null,
        threadCount = 0,
        createdDateType = ChatCreatedDateType.always;

  const ChatAndOgpListItem.threadTop({
    super.key,
    required this.message,
    required this.createdAt,
  })  : onRead = null,
        onThread = null,
        onConvertTodo = null,
        threadCount = 0,
        createdDateType = ChatCreatedDateType.always;

  final String message;
  final DateTime createdAt;
  final void Function()? onRead;
  final void Function()? onThread;
  final void Function()? onConvertTodo;
  final int threadCount;
  final ChatCreatedDateType createdDateType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = getLinks(text: message);
    return ChatListItem(
      text: message,
      createdAt: createdAt,
      createdDateType: createdDateType,
      launchUrl: (link) async {
        if (!await launchUrl(link)) {
          throw Exception('Could not launch ${link.toString()}');
        }
      },
      threadCount: threadCount,
      onRead: onRead,
      onThread: onThread,
      onConvertTodo: onConvertTodo,
      bottomWidget: _UrlPreviewCard(links: links),
    );
  }
}

class _UrlPreviewCard extends ConsumerWidget {
  const _UrlPreviewCard({
    required this.links,
  });

  final List<Uri> links;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SelectionContainer.disabled(
      child: links.isEmpty
          ? const SizedBox.shrink()
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: context.appSpacing.small,
              ),
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
    );
  }
}
