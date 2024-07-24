import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/systems/context_extension.dart';
import 'package:quick_flutter/widget/markdown_text_editing_controller.dart';
import 'package:quick_flutter/widget/markdown_text_field.dart';

class ChatMainTextField extends HookConsumerWidget {
  const ChatMainTextField({
    Key? key,
    this.onChanged,
    this.onAddDraft,
    this.onSubmit,
  }) : super(key: key);

  final Function(String value)? onChanged;
  final Function(String value)? onAddDraft;
  final Future Function(String value)? onSubmit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMarkdownTextEditingController();
    final focus = useFocusNode();
    final canSubmit = useState(false);
    final hasFocus = useState(false);

    final canCreateDraft = useState(false);

    useEffect(
      () {
        listener() {
          canSubmit.value = controller.text.isNotEmpty;
          canCreateDraft.value = controller.text.isNotEmpty;
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

    // ignore: no_leading_underscores_for_local_identifiers
    _onSubmit() async {
      final value = controller.text;
      controller.clear();
      await onSubmit?.call(value);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: MarkdownTextField(
            controller: controller,
            focus: focus,
            hintText: 'Write a note',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
          child: Row(
            children: [
              TextButton(
                onPressed: canCreateDraft.value
                    ? () {
                        onAddDraft?.call(controller.text);

                        controller.clear();
                        focus.requestFocus();
                      }
                    : null,
                child: const Text('convert to draft(Cmd + N)'),
              ),
              const Spacer(),
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
    );
  }
}
