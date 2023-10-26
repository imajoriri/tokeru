import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/store/bookmark_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/widget/chat_tile.dart';
import 'package:quick_flutter/widget/multi_keyboard_shortcuts.dart';

class MemoScreen extends HookConsumerWidget {
  const MemoScreen({super.key});

  void toggleBookmark({required WidgetRef ref, required Memo memo}) async {
    if (memo.isBookmark) {
      await ref.read(removeBookmarkProvider(memo.id));
    } else {
      await ref.read(addBookmarkProvider(memo.id));
    }
    ref.invalidate(bookmarkProvider);
    ref.invalidate(memosProvider);
  }

  void addMessage(WidgetRef ref, TextEditingController textController) async {
    await ref.read(addMemoProvider(textController.text));
    ref.invalidate(memosProvider);
    textController.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final focus = useFocusNode();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _AllMemoList(
                    onTapBookmark: (memo) {
                      toggleBookmark(ref: ref, memo: memo);
                    },
                  ),
                ),
              ),
              MultiKeyBoardShortcuts(
                onCommandEnter: () {
                  if (!focus.hasFocus) {
                    return;
                  }
                  addMessage(ref, textController);
                },
                onEsc: () {
                  if (!focus.hasFocus) {
                    return;
                  }
                  focus.unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: textController,
                          focusNode: focus,
                          autofocus: true,
                        ),
                      ),
                      SubmitButton(
                          text: "add memo",
                          onTap: () {
                            addMessage(ref, textController);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _BookmarkList(
            onTapBookmark: (memo) {
              toggleBookmark(ref: ref, memo: memo);
            },
          ),
        ],
      ),
    );
  }
}

class _AllMemoList extends HookConsumerWidget {
  const _AllMemoList({required this.onTapBookmark});
  final void Function(Memo memo) onTapBookmark;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(memosProvider);
    if (provider.hasError) {
      return Text(provider.error.toString());
    }
    final memos = provider.valueOrNull ?? [];

    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) {
        return ChatTile(
          memo: memos[index],
          onTapBookmark: onTapBookmark,
          onTap: () {
            ref
                .read(sidebarScreenControllerProvider.notifier)
                .open(memo: memos[index]);
          },
        );
      },
      itemCount: memos.length,
    );
  }
}

class _BookmarkList extends HookConsumerWidget {
  const _BookmarkList({required this.onTapBookmark});
  final void Function(Memo memo) onTapBookmark;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(bookmarkProvider);
    if (provider.hasError) {
      return Text(provider.error.toString());
    }
    final bookmarks = provider.valueOrNull ?? [];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ChatTile(
            memo: bookmarks[index],
            onTapBookmark: onTapBookmark,
            onTap: () {
              ref
                  .read(sidebarScreenControllerProvider.notifier)
                  .open(memo: bookmarks[index]);
            },
          );
        },
        itemCount: bookmarks.length,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
