import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_haptics/haptics.dart';
import 'package:tokeru_model/controller/chats/chats.dart';
import 'package:tokeru_model/controller/read/read_controller.dart';
import 'package:tokeru_model/controller/read_all/read_all_controller.dart';
import 'package:tokeru_model/controller/thread/thread.dart';
import 'package:tokeru_model/model.dart';
import 'package:tokeru_desktop/widget/focus_nodes.dart';
import 'package:tokeru_widgets/widgets.dart';

part 'chat_list.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Expanded(
          child: Stack(
            // fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              _ChatList(),
              _ReadButton(),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: _TodoModal(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: ChatTextField(
            focusNode: chatFocusNode,
            onSubmit: (message) {
              ref.read(chatsProvider.notifier).addChat(message: message);
              FirebaseAnalytics.instance.logEvent(
                name: AnalyticsEventName.addChat.name,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TodoModal extends HookWidget {
  const _TodoModal();

  @override
  Widget build(BuildContext context) {
    final isHovered = useState(false);
    return MouseRegion(
      onEnter: (_) {
        isHovered.value = true;
        TokeruHaptics().hovered();
      },
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        height: isHovered.value ? 300 : 100,
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text('fff'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadButton extends ConsumerWidget {
  const _ReadButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readAll = ref.watch(readAllProvider);
    return readAll.when(
      skipLoadingOnReload: true,
      data: (value) {
        if (value) {
          return const SizedBox.shrink();
        }
        return Positioned(
          bottom: context.appSpacing.small,
          child: AppButton(
            onPressed: () => ref
                .read(readControllerProvider.notifier)
                .markAsRead(DateTime.now()),
            contentColor: context.appColors.onPrimary,
            backgroundColor: context.appColors.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    // icon
                    WidgetSpan(
                      child: Icon(
                        AppIcons.read,
                        size: 16,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 4),
                    ),
                    TextSpan(
                      text: 'Mark all as read',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
    );
  }
}
