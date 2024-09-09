import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_desktop/widget/list_items/chat_list_items.dart';
import 'package:tokeru_desktop/widget/text_field/chat_text_field.dart';
import 'package:tokeru_model/controller/chats/chats.dart';
import 'package:tokeru_model/model/app_item/app_item.dart';
import 'package:tokeru_widgets/widgets.dart';

const _duration = Duration(milliseconds: 300);

class ChatModal extends HookWidget {
  const ChatModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final minimum = useState(false);
    return FocusableActionDetector(
      mouseCursor:
          minimum.value ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: TapRegion(
        onTapInside: (_) => minimum.value = false,
        onTapOutside: (_) => minimum.value = true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.appColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedSize(
            duration: _duration,
            curve: Curves.easeOutExpo,
            child: AnimatedSwitcher(
              duration: _duration,
              child: minimum.value ? const _Min() : const _Max(),
            ),
          ),
        ),
      ),
    );
  }
}

class _Max extends HookConsumerWidget {
  const _Max();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatsProvider);
    final focusNode = useFocusNode();
    useEffect(
      () {
        focusNode.requestFocus();
        return () => focusNode.dispose();
      },
      const [],
    );
    return SizedBox(
      width: 500,
      height: 500,
      child: Column(
        children: [
          Expanded(
            child: chats.when(
              skipLoadingOnReload: true,
              data: (chats) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.extentAfter < 300) {
                      ref.read(chatsProvider.notifier).fetchNext();
                    }
                    return false;
                  },
                  child: ChatListItems<AppChatItem>.main(
                    chats: chats,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: ChatTextField.chat(
              focusNode: focusNode,
              onSubmit: (message) {
                ref.read(chatsProvider.notifier).addChat(message: message);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Min extends StatelessWidget {
  const _Min({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 30,
      child: const Text('最小化'),
    );
  }
}
