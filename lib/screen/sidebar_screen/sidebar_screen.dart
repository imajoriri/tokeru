import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/sidebar_screen/controller.dart';
import 'package:quick_flutter/store/focus_store.dart';
import 'package:quick_flutter/store/memo_store.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

class SidebarScreen extends HookConsumerWidget {
  const SidebarScreen({super.key});

  static const debounceDuration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sidebarScreenControllerProvider);

    final textController = useMarkdownTextEditingController();
    // 最初の更新(開いてるメモを変更した時)を検知
    final didFirstUpdateMemo = useState(false);

    useEffect(() {
      textController.text = state.memo?.content ?? '';
      didFirstUpdateMemo.value = false;
      ref.watch(focusNodeProvider(FocusNodeType.sidebarChat)).requestFocus();
      return null;
    }, [state.memo]);

    // 画面を破棄する時にtextControllerもdisposeする
    useEffect(() {
      return () {
        textController.dispose();
      };
    }, []);

    Timer? debounce;
    useEffect(
      () {
        textController.addListener(() {
          if (didFirstUpdateMemo.value == false) {
            didFirstUpdateMemo.value = true;
            return;
          }
          if (debounce?.isActive ?? false) {
            debounce?.cancel();
          }

          debounce = Timer(debounceDuration, () {
            ref.read(memoStoreProvider.notifier).updateMemo(
                  id: ref.read(sidebarScreenControllerProvider).memo!.id,
                  content: textController.text,
                );
          });
        });

        return () {
          debounce?.cancel();
        };
      },
      [textController],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(1, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(sidebarScreenControllerProvider.notifier)
                          .close();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MarkdownTextField(
                  controller: textController,
                  focus:
                      ref.watch(focusNodeProvider(FocusNodeType.sidebarChat)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
