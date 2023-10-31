import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
import 'package:quick_flutter/widget/multi_keyboard_shortcuts.dart';

class ChatTextField extends HookConsumerWidget {
  const ChatTextField({
    required this.onSubmit,
    required this.controller,
    required this.focus,
    Key? key,
  }) : super(key: key);

  final Function(bool isBookmark) onSubmit;
  final MarkdownTextEditingController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = useState(false);
    final hasFocus = useState(false);
    // ブックマークとして投稿するかどうか
    final isBookmark = useState(false);
    useEffect(() {
      listener() {
        canSubmit.value = controller.text.isNotEmpty;
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
      onSubmit(isBookmark.value);
      isBookmark.value = false;
      controller.clear();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
            color: hasFocus.value
                ? Theme.of(context).colorScheme.outlineVariant
                : Theme.of(context).colorScheme.outline,
            width: 1.0),
        boxShadow: [
          if (hasFocus.value)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: MultiKeyBoardShortcuts(
        onCommandEnter: () {
          if (!focus.hasFocus) {
            return;
          }
          _onSubmit();
        },
        onEsc: () {
          if (!focus.hasFocus) {
            return;
          }
          controller.clear();
        },
        child: Column(
          children: [
            MarkdownTextField(
              controller: controller,
              focus: focus,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  // ドラフトボタン
                  const Spacer(),
                  // ブックマークとして投稿するボタン
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      minimumSize: const Size(48, 32),
                    ),
                    onPressed: () {
                      isBookmark.value = !isBookmark.value;
                    },
                    child: Icon(
                      Icons.bookmark,
                      size: 16,
                      color: isBookmark.value
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      minimumSize: const Size(48, 32),
                    ),
                    onPressed: canSubmit.value
                        ? () {
                            _onSubmit();
                          }
                        : null,
                    child: const Icon(
                      Icons.send,
                      size: 16,
                      color: Colors.white,
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
