import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/memo/controller.dart';
import 'package:quick_flutter/store/focus_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
import 'package:quick_flutter/widget/multi_keyboard_shortcuts.dart';

class ChatMainTextField extends HookConsumerWidget {
  const ChatMainTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMarkdownTextEditingController();
    final focus = ref.watch(focusNodeProvider(FocusNodeType.chat));
    final canSubmit = useState(false);
    final hasFocus = useState(false);
    // ブックマークとして投稿するかどうか
    final isBookmark = useState(false);
    // 明示的にブックマークをOFFにして投稿するかどうか
    final isBookmarkOff = useState(false);

    useEffect(() {
      listener() {
        canSubmit.value = controller.text.isNotEmpty;

        // タイトルから始まる場合はブックマークとして投稿する
        if (controller.text.startsWith('# ') && !isBookmarkOff.value) {
          isBookmark.value = true;
        } else {
          isBookmark.value = false;
        }
      }

      controller.addListener(listener);
      return () {
        controller.removeListener(listener);
      };
    }, [controller.text]);

    useEffect(() {
      listener() {
        hasFocus.value = focus.hasFocus;
      }

      focus.addListener(listener);
      return () {
        focus.removeListener(listener);
      };
    }, [focus.hasFocus]);

    // ignore: no_leading_underscores_for_local_identifiers
    _onSubmit() {
      ref
          .read(chatScreenControllerProvider.notifier)
          .addMainMessage(text: controller.text, isBookmark: isBookmark.value);
      isBookmark.value = false;
      controller.clear();
      isBookmarkOff.value = false;
    }

    return Focus(
      focusNode: focus,
      child: MultiKeyBoardShortcuts(
        onCommandEnter: () {
          if (!focus.hasFocus || !canSubmit.value) {
            return;
          }
          _onSubmit();
        },
        onEsc: () {
          if (!focus.hasFocus) {
            return;
          }
          focus.unfocus();
          ref.watch(focusNodeProvider(FocusNodeType.main)).requestFocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MarkdownTextField(
                controller: controller,
                // focus: focus,
                hintText: hasFocus.value
                    ? 'write a note'
                    : 'Press Command + N to focus',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(chatScreenControllerProvider.notifier).addDraft(
                            controller.text,
                          );
                      controller.clear();
                      focus.requestFocus();
                    },
                    child: const Text('convert to draft'),
                  ),
                  const Spacer(),
                  // ブックマークとして投稿するボタン
                  TextButton(
                    onPressed: () {
                      isBookmark.value = !isBookmark.value;
                      if (!isBookmark.value) {
                        isBookmarkOff.value = true;
                      }
                    },
                    child: Icon(
                      isBookmark.value ? Icons.bookmark : Icons.bookmark_border,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: canSubmit.value
                        ? () {
                            _onSubmit();
                          }
                        : null,
                    child: Icon(
                      Icons.send,
                      color: context.colorScheme.onPrimary,
                    ),
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
