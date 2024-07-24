import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

class ChatDraftTextField extends HookConsumerWidget {
  const ChatDraftTextField({
    required this.defaultValue,
    this.onSubmit,
    this.onChanged,
    this.onDebounceChanged,
    this.textController,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onSubmit;
  final Function(String value)? onChanged;
  final Function(String value)? onDebounceChanged;

  static const debounceDuration = Duration(milliseconds: 1000);

  final String defaultValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = useState(false);
    final hasFocus = useState(false);
    final focus = focusNode ?? useFocusNode();
    final controller =
        textController ?? useMarkdownTextEditingController(text: defaultValue);

    useEffect(
      () {
        listener() {
          canSubmit.value = controller.text.isNotEmpty;
          onChanged?.call(controller.text);
        }

        controller.addListener(listener);
        return () {
          controller.removeListener(listener);
        };
      },
      [controller.text],
    );

    useEffect(
      () {
        listener() {
          hasFocus.value = focus.hasFocus;
        }

        focus.addListener(listener);
        return () {
          focus.removeListener(listener);
        };
      },
      [focus.hasFocus],
    );

    Timer? debounce;
    useEffect(
      () {
        controller.addListener(() {
          if (debounce?.isActive ?? false) {
            debounce?.cancel();
          }

          debounce = Timer(debounceDuration, () {
            onDebounceChanged?.call(controller.text);
          });
        });

        return () {
          debounce?.cancel();
        };
      },
      [controller],
    );

    return Container(
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
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextButton(
              onPressed: () {
                onSubmit?.call(controller.text);
              },
              child: const Icon(
                Icons.send,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
