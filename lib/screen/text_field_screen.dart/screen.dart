// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/store/draft_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/chat_draft_text_field.dart';
import 'package:quick_flutter/widget/chat_main_text_field.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const channel = MethodChannel("net.cbtdev.sample/method");
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'openPanel':
          break;
        default:
          break;
      }
    });

    final drafts = ref.watch(draftStreamStore).value ?? [];
    final controllers = drafts
        .map((d) => useMarkdownTextEditingController(text: d.content))
        .toList();

    return Material(
      // color: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
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
          child: Column(
            key: globalKey,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
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
                  await ref
                      .read(memoStoreProvider.notifier)
                      .addMemo(content: value, isBookmark: false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
