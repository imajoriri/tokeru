import 'package:collection/collection.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/memo/chat_draft_text_field.dart';
import 'package:quick_flutter/screen/memo/chat_main_text_field.dart';
import 'package:quick_flutter/store/draft_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';

class TextFieldScreen extends HookConsumerWidget {
  TextFieldScreen({super.key});

  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftStoreProvider).valueOrNull ?? [];
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RenderBox? box =
            globalKey.currentContext?.findRenderObject() as RenderBox?;
        final size = box?.size;
        if (size != null) {
          final height = size.height;
          DesktopWindow.setWindowSize(
              Size(MediaQuery.of(context).size.width, height + 100));
        }
      });
      return null;
    }, []);
    return Material(
      // color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
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
                  ...drafts.mapIndexed((index, e) {
                    return ChatDraftTextField(
                      key: ValueKey(e.id),
                      defaultValue: e.content,
                      index: index,
                      draftId: e.id,
                    );
                  }),

                  // main
                  ChatMainTextField(
                    key: globalKey,
                    onChanged: (value) {
                      RenderBox? box = globalKey.currentContext
                          ?.findRenderObject() as RenderBox?;
                      final size = box?.size;
                      if (size != null) {
                        final height = size.height;
                        DesktopWindow.setWindowSize(Size(
                            MediaQuery.of(context).size.width, height + 100));
                      }
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
