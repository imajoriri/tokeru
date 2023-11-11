import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/screen/memo/controller.dart';
import 'package:quick_flutter/store/focus_store.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';
import 'package:quick_flutter/widget/multi_keyboard_shortcuts.dart';

class ChatDraftTextField extends HookConsumerWidget {
  const ChatDraftTextField({
    required this.controller,
    required this.index,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final int index;

  Future<void> onSubmit(WidgetRef ref) async {
    ref.read(chatScreenControllerProvider.notifier).addDraftMessage(
          text: controller.text,
          index: index,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = useState(false);
    final hasFocus = useState(false);
    final focus = useFocusNode();

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

    return MultiKeyBoardShortcuts(
      onCommandEnter: () {
        if (!focus.hasFocus || !canSubmit.value) {
          return;
        }
        onSubmit(ref);
      },
      onEsc: () {
        if (!focus.hasFocus) {
          return;
        }
        focus.unfocus();
        ref.watch(focusNodeProvider(FocusNodeType.main)).requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        // 下線部にborder
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: context.colorScheme.outline,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: MarkdownTextField(
                controller: controller,
                focus: focus,
                hintText: '',
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                onSubmit.call(ref);
              },
              child: const Icon(
                Icons.send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
