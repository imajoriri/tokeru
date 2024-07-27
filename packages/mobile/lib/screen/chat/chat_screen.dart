import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/app_item/app_items.dart';
import 'package:tokeru_model/controller/user/user_controller.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoginButton =
        ref.watch(userControllerProvider).valueOrNull?.isAnonymous ?? true;
    final chats = ref.watch(appItemsProvider);
    final textEditingController = useTextEditingController();

    return Scaffold(
      backgroundColor: context.appColors.surface,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(context.appSpacing.medium),
            child: TextButtonSmall(
              onPressed: () {
                if (showLoginButton) {
                  ref.read(userControllerProvider.notifier).signInWithGoogle();
                  return;
                }

                ref.read(userControllerProvider.notifier).signOut();
              },
              child: Text(showLoginButton ? 'Login' : 'Logout'),
            ),
          ),
          Expanded(
            child: chats.when(
              data: (chats) {
                return ListView.builder(
                  itemCount: chats.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return switch (chat) {
                      AppChatItem() => ChatListItem.chat(
                          text: chat.message, launchUrl: (uri) {}),
                      _ => const SizedBox.shrink(),
                    };
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
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
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
                      .read(appItemsProvider.notifier)
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
