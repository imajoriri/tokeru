// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/memo/chat_draft_text_field.dart';
import 'package:quick_flutter/screen/memo/chat_main_text_field.dart';
import 'package:quick_flutter/store/draft_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  void updateWindowSize(BuildContext context) {
    RenderBox? box = globalKey.currentContext?.findRenderObject() as RenderBox?;
    final size = box?.size;
    if (size != null) {
      final height = size.height;
      // これ他おそらくmainを変えてしまっている
      DesktopWindow.setWindowSize(
          Size(MediaQuery.of(context).size.width, height + 50));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const channel = MethodChannel("net.cbtdev.sample/method");
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'openPanel':
          updateWindowSize(context);
          break;
        default:
          break;
      }
    });

    final drafts = ref.watch(draftStreamStore).value ?? [];
    final controllers = drafts
        .map((d) => useMarkdownTextEditingController(text: d.content))
        .toList();

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     // await ref.watch(draftStoreProvider.future);
    //     // updateWindowSize(context);
    //     // memoStoreProviderのaddMemoでstateがないと言われるのであらかじめ読んでおく
    //     ref.watch(memoStoreProvider);
    //   });
    //   return null;
    // }, []);
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
                    onChanged: (value) {
                      updateWindowSize(context);
                    },
                    onAddDraft: (value) async {
                      await ref
                          .read(draftControllerProvider.notifier)
                          .addDraft(value);
                      updateWindowSize(context);
                    },
                    onSubmit: (value) async {
                      await ref
                          .read(memoStoreProvider.notifier)
                          .addMemo(content: value, isBookmark: false);
                      updateWindowSize(context);
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
