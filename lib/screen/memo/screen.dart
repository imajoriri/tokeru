import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/memo/chat_draft_text_field.dart';
import 'package:quick_flutter/screen/memo/chat_main_text_field.dart';
import 'package:quick_flutter/store/draft_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/chat_tile.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';

class MemoScreen extends HookConsumerWidget {
  const MemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftStreamStore).value ?? [];
    final controllers = drafts
        .map((d) => useMarkdownTextEditingController(text: d.content))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _AllMemoList(),
          ),
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
                ...controllers.mapIndexed((index, c) {
                  if (drafts[index].content != c.text) {
                    c.text = drafts[index].content;
                  }
                  return ChatDraftTextField(
                    textController: c,
                    defaultValue: c.text,
                    onDebounceChanged: (value) {
                      ref.read(draftControllerProvider.notifier).updateDraft(
                            id: drafts[index].id,
                            content: value,
                          );
                    },
                    onSubmit: (value) async {
                      await ref
                          .read(memoStoreProvider.notifier)
                          .addMemo(content: value, isBookmark: false);
                      ref
                          .read(draftControllerProvider.notifier)
                          .removeDraft(drafts[index].id);
                    },
                  );
                }),

                // main
                ChatMainTextField(
                  onAddDraft: (value) async {
                    await ref
                        .read(draftControllerProvider.notifier)
                        .addDraft(value);
                  },
                  onSubmit: (value) async {
                    ref
                        .read(memoStoreProvider.notifier)
                        .addMemo(content: value, isBookmark: false);
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

class _AllMemoList extends HookConsumerWidget {
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
          onTap: () {},
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
