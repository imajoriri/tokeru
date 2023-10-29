import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/widget/multi_keyboard_shortcuts.dart';

class ChatTextField extends HookConsumerWidget {
  const ChatTextField({
    required this.onSubmit,
    required this.controller,
    required this.focus,
    Key? key,
  }) : super(key: key);

  final Function() onSubmit;
  final TextEditingController controller;
  final FocusNode focus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = useState(false);
    final hasFocus = useState(false);
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
            color: hasFocus.value
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.5),
            width: 0.5),
        boxShadow: [
          if (hasFocus.value)
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
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
          onSubmit();
        },
        onEsc: () {
          if (!focus.hasFocus) {
            return;
          }
          controller.clear();
        },
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focus,
                controller: controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            FilledButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
              ),
              onPressed: controller.text.isEmpty
                  ? null
                  : () {
                      onSubmit();
                    },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
