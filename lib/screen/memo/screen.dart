import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/store/focus_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/widget/chat_text_field.dart';
import 'package:quick_flutter/widget/chat_tile.dart';
import 'package:quick_flutter/widget/custome_expansion_tile.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';

class MemoScreen extends HookConsumerWidget {
  const MemoScreen({super.key});

  void toggleBookmark({required WidgetRef ref, required Memo memo}) async {
    if (memo.isBookmark) {
      await ref.read(memoStoreProvider.notifier).removeBookmark(memo);
    } else {
      await ref.read(memoStoreProvider.notifier).addBookmark(memo);
    }
  }

  void addMessage(
      {required WidgetRef ref,
      required TextEditingController textController,
      required bool isBookmark}) async {
    await ref
        .read(memoStoreProvider.notifier)
        .addMemo(content: textController.text, isBookmark: isBookmark);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = MarkdownTextEditingController();

    // 画面を破棄する時にtextControllerもdisposeする
    useEffect(() {
      return () {
        textController.dispose();
      };
    }, []);

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
            onSubmit: (bool isBookmark) {
              addMessage(
                  ref: ref,
                  textController: textController,
                  isBookmark: isBookmark);
            },
            controller: textController,
            focus: ref.watch(focusNodeProvider(FocusNodeType.chat)),
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
    final provider = ref.watch(memoStoreProvider);
    if (provider.hasError) {
      return Text(provider.error.toString());
    }
    final memos = provider.valueOrNull?.memos ?? [];

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
          onChanged: (value) {
            ref
                .read(memoStoreProvider.notifier)
                .updateMemo(id: memos[index].id, content: value);
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
    final provider = ref.watch(memoStoreProvider);
    if (provider.hasError) {
      return Text(provider.error.toString());
    }
    final bookmarks = provider.valueOrNull?.bookmarks ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: CustomExpansionTile(
        isHoverOpen: false,
        title: Row(
          children: [
            Icon(
              Icons.bookmark,
              color: Theme.of(context).colorScheme.primary,
              size: 12,
            ),
            const SizedBox(width: 4),
            Text("bookmarks (${bookmarks.length})",
                style: Theme.of(context).textTheme.titleSmall!),
          ],
        ),
        children: [
          ConstrainedBox(
            // 画面の半分のサイズをmaxHeightにする
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2),
            child: CustomScrollView(
              slivers: [
                SliverReorderableList(
                  itemBuilder: (context, index) {
                    return ReorderableDragStartListener(
                      index: index,
                      key: Key(bookmarks[index].id),
                      child: ChatTile(
                        memo: bookmarks[index],
                        maxLines: 1,
                        onTapBookmark: onTapBookmark,
                        onTap: () {
                          ref
                              .read(sidebarScreenControllerProvider.notifier)
                              .open(memo: bookmarks[index]);
                        },
                      ),
                    );
                  },
                  itemCount: bookmarks.length,
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    ref
                        .watch(memoStoreProvider.notifier)
                        .updateBookmarkOrder(oldIndex, newIndex);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
