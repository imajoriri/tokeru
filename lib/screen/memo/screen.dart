import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/model/memo.dart';
import 'package:quick_flutter/screen/memo/chat_draft_text_field.dart';
import 'package:quick_flutter/screen/memo/chat_main_text_field.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/store/draft_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/chat_tile.dart';
import 'package:quick_flutter/widget/custome_expansion_tile.dart';

class MemoScreen extends HookConsumerWidget {
  const MemoScreen({super.key});

  void toggleBookmark({required WidgetRef ref, required Memo memo}) async {
    if (memo.isBookmark) {
      await ref.read(memoStoreProvider.notifier).removeBookmark(memo);
    } else {
      await ref.read(memoStoreProvider.notifier).addBookmark(memo);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftStoreProvider).valueOrNull ?? [];
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
          // _FixedBookmarkList(
          //   onTapBookmark: (memo) {
          //     toggleBookmark(ref: ref, memo: memo);
          //   },
          // ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: context.colorScheme.outline,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow,
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // draft
                ...drafts.mapIndexed((index, e) {
                  return ChatDraftTextField(
                    key: ValueKey(e.id),
                    defaultValue: e.content,
                    index: index,
                    draftId: e.id,
                  );
                }),

                // main
                const ChatMainTextField(),
              ],
            ),
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

class _FixedBookmarkList extends HookConsumerWidget {
  const _FixedBookmarkList({required this.onTapBookmark});
  final void Function(Memo memo) onTapBookmark;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(memoStoreProvider);
    if (provider.hasError) {
      return Text(provider.error.toString());
    }
    final bookmarks = provider.valueOrNull?.bookmarks ?? [];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
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
          ),
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2),
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (context, index) {
                return ChatTile(
                  memo: bookmarks[index],
                  onTapBookmark: onTapBookmark,
                  onTap: () {
                    ref
                        .read(sidebarScreenControllerProvider.notifier)
                        .open(memo: bookmarks[index]);
                  },
                  onChanged: (value) {
                    ref
                        .read(memoStoreProvider.notifier)
                        .updateMemo(id: bookmarks[index].id, content: value);
                  },
                );
              },
              itemCount: bookmarks.length,
            ),
          ),
        ],
      ),
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
        children: List.generate(bookmarks.length, (index) {
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
        }),
        // children: [
        //   Container(
        //     // 画面の半分のサイズをmaxHeightにする
        //     constraints: BoxConstraints(
        //         maxHeight: MediaQuery.of(context).size.height / 2),
        //     // height: 300,
        //     child: CustomScrollView(
        //       slivers: [
        //         SliverReorderableList(
        //           itemBuilder: (context, index) {
        //             return ReorderableDragStartListener(
        //               index: index,
        //               key: Key(bookmarks[index].id),
        //               child: ChatTile(
        //                 memo: bookmarks[index],
        //                 maxLines: 1,
        //                 onTapBookmark: onTapBookmark,
        //                 onTap: () {
        //                   ref
        //                       .read(sidebarScreenControllerProvider.notifier)
        //                       .open(memo: bookmarks[index]);
        //                 },
        //               ),
        //             );
        //           },
        //           itemCount: bookmarks.length,
        //           onReorder: (oldIndex, newIndex) {
        //             if (oldIndex < newIndex) {
        //               newIndex -= 1;
        //             }
        //             ref
        //                 .watch(memoStoreProvider.notifier)
        //                 .updateBookmarkOrder(oldIndex, newIndex);
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
