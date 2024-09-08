import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_widgets/widgets.dart';

/// チャットのTextField。
class ChatTextField extends HookConsumerWidget {
  const ChatTextField.chat({
    super.key,
    required this.onSubmit,
    this.focusNode,
    this.textEditingController,
  })  : hintText = 'Talk to myself',
        maxLines = null;

  const ChatTextField.todo({
    super.key,
    required this.onSubmit,
  })  : textEditingController = null,
        focusNode = null,
        maxLines = 1,
        hintText = 'Add To-Do';

  final FocusNode? focusNode;

  /// submitボタンを押した時の処理。
  final void Function(String message) onSubmit;

  final TextEditingController? textEditingController;

  final String hintText;

  final int? maxLines;

  Future<void> _send({
    required TextEditingController textEditingController,
    required WidgetRef ref,
  }) async {
    if (textEditingController.text.isEmpty) return;

    onSubmit(textEditingController.text);
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasFocus = useState(false);
    final canSubmit = useState(false);

    final effectiveTextController =
        textEditingController ?? useTextEditingController();
    effectiveTextController.addListener(() {
      canSubmit.value = effectiveTextController.text.isNotEmpty;
    });

    final effectiveFocusNode = focusNode ?? useFocusNode();
    // 日本語入力などでの変換中は無視するためのフラグ
    final isValid = useState(false);
    effectiveFocusNode.onKeyEvent = ((node, event) {
      isValid.value = effectiveTextController.value.composing.isValid;
      return KeyEventResult.ignored;
    });

    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 150));
    final colorTween = ColorTween(
      begin: context.appColors.outlineSubtle,
      end: context.appColors.outline,
    );
    final shadowColorTween = ColorTween(
      begin: Colors.transparent,
      end: context.appColors.outlineStrong.withOpacity(0.2),
    );

    return AnimatedBuilder(
      animation: animationController,
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          if (!isValid.value)
            const SingleActivator(LogicalKeyboardKey.enter): () => _send(
                  textEditingController: effectiveTextController,
                  ref: ref,
                ),
        },
        child: Focus(
          onFocusChange: (value) {
            hasFocus.value = effectiveFocusNode.hasFocus;
            if (value) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.appSpacing.small,
              vertical: context.appSpacing.smallX,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: effectiveTextController,
                    maxLines: maxLines,
                    focusNode: effectiveFocusNode,
                    style: context.appTextTheme.bodyMedium,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: hintText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: AppTextButton.small(
                    onPressed: canSubmit.value
                        ? () => _send(
                              textEditingController: effectiveTextController,
                              ref: ref,
                            )
                        : null,
                    text: const Text('Add'),
                    icon: const Icon(Icons.add),
                    buttonType: AppTextButtonType.filled,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorTween.evaluate(animationController)!,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            color: context.appColors.surface,
            boxShadow: [
              BoxShadow(
                color: shadowColorTween.evaluate(animationController)!,
                offset: const Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}
