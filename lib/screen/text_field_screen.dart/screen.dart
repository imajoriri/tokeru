import 'package:collection/collection.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/memo/chat_draft_text_field.dart';
import 'package:quick_flutter/screen/memo/chat_main_text_field.dart';
import 'package:quick_flutter/store/draft_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  void updateWindowSize(BuildContext context) {
    RenderBox? box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    final size = box?.size;
    if (size != null) {
      final height = size.height;
      DesktopWindow.setWindowSize(
          Size(MediaQuery.of(context).size.width, height + 10));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftStoreProvider).valueOrNull ?? [];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.watch(memoStoreProvider);
        updateWindowSize(context);
      });
      return null;
    }, []);
    return Material(
      // color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          key: globalKey,
          mainAxisSize: MainAxisSize.min,
          children: [
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // draft
                  ...drafts.mapIndexed((index, draft) {
                    return ChatDraftTextField(
                      key: ValueKey(draft.id),
                      defaultValue: draft.content,
                      draftId: draft.id,
                      onChanged: (value) {
                        updateWindowSize(context);
                      },
                      onDebounceChanged: (value) {
                        ref.read(draftStoreProvider.notifier).updateDraft(
                              id: draft.id,
                              content: value,
                            );
                      },
                      onSubmit: (value) async {
                        await ref
                            .read(memoStoreProvider.notifier)
                            .addMemo(content: value, isBookmark: false);
                        await ref
                            .read(draftStoreProvider.notifier)
                            .removeDraft(index);
                        // ignore: use_build_context_synchronously
                        updateWindowSize(context);
                      },
                    );
                  }),

                  // main
                  ChatMainTextField(
                    onChanged: (value) {
                      updateWindowSize(context);
                    },
                    onAddDraft: (value) async {
                      await ref
                          .read(draftStoreProvider.notifier)
                          .addDraft(value);
                      // ignore: use_build_context_synchronously
                      updateWindowSize(context);
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
      ),
    );
  }
}
