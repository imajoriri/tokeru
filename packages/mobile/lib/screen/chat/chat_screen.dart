import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:tokeru_model/controller/chats/chats.dart';
import 'package:tokeru_model/controller/ogp_controller/ogp_controller.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoginButton =
        ref.watch(userControllerProvider).valueOrNull?.isAnonymous ?? true;
    final chats = ref.watch(chatsProvider);
    final textEditingController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      backgroundColor: context.appColors.surface,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(context.appSpacing.medium),
            child: AppTextButton(
              onPressed: () {
                if (showLoginButton) {
                  ref.read(userControllerProvider.notifier).signInWithApple();
                  return;
                }

                ref.read(userControllerProvider.notifier).signOut();
              },
              text: Text(showLoginButton ? 'Login' : 'Logout'),
            ),
          ),
          AppTextButton(
            onPressed: () {
              Navigator.of(context).push(SwipeablePageRoute(
                builder: (BuildContext context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('Chat'),
                  ),
                  body: const Center(
                    child: Text('Chat'),
                  ),
                ),
              ));
            },
            text: const Text('push'),
          ),
          Expanded(
            child: chats.when(
              data: (chats) {
                return ListView.builder(
                  itemCount: chats.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final appItem = chats[index];
                    return _ChatListItemChat(appItem: appItem);
                  },
                );
              },
              error: (e, _) {
                return Center(
                  child: Text(e.toString()),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          // Chat input
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.appSpacing.smallX),
                  child: TextField(
                    controller: textEditingController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SubmitButton(
                onPressed: () {
                  ref
                      .read(chatsProvider.notifier)
                      .addChat(message: textEditingController.text);
                  textEditingController.clear();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
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
