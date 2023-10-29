import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/store/bookmark_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/widget/chat_text_field.dart';
import 'package:quick_flutter/widget/chat_tile.dart';

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
      body: Column(
        children: [
          _BookmarkList(
            onTapBookmark: (memo) {
              toggleBookmark(ref: ref, memo: memo);
            },
          ),
          Expanded(
            child: _AllMemoList(
              onTapBookmark: (memo) {
                toggleBookmark(ref: ref, memo: memo);
              },
            ),
          ),
          ChatTextField(
            onSubmit: () {
              addMessage(ref, textController);
            },
            controller: textController,
            focus: focus,
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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ChatTile(
            memo: bookmarks[index],
            maxLines: 1,
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
