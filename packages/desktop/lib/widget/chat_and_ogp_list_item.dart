import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/ogp_controller/ogp_controller.dart';
import 'package:tokeru_model/controller/read/read_controller.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatAndOgpListItem extends ConsumerWidget {
  const ChatAndOgpListItem({
    super.key,
    required this.chat,
    required this.showRead,
    required this.showThread,
  });

  final AppChatItem chat;
  final bool showThread;
  final bool showRead;

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
      onRead: showRead
          ? () {
              ref.read(readControllerProvider.notifier).markAsReadAsChat(chat);
            }
          : null,
      onThread: showThread
          ? () {
              ref.read(selectedThreadProvider.notifier).setThread(
                    chat: chat,
                  );
            }
          : null,
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
