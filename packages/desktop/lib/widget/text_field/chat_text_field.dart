import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_widgets/widgets.dart';

/// チャットのTextField。
class ChatTextField extends HookConsumerWidget {
  const ChatTextField({
    Key? key,
    required this.focusNode,
    required this.onSubmit,
  }) : super(key: key);

  final FocusNode focusNode;

  /// submitボタンを押した時の処理。
  final void Function(String message) onSubmit;

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
    final textEditingController = useTextEditingController();
    final hasFocus = useState(false);
    final canSubmit = useState(false);

    textEditingController.addListener(() {
      canSubmit.value = textEditingController.text.isNotEmpty;
    });

    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 150));
    final colorTween = ColorTween(
      begin: context.appColors.outline,
      end: context.appColors.outlineStrong,
    );
    final shadowColorTween = ColorTween(
      begin: Colors.transparent,
      end: context.appColors.outlineStrong.withOpacity(0.2),
    );

    return AnimatedBuilder(
      animation: animationController,
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.enter, meta: true): () =>
              _send(
                textEditingController: textEditingController,
                ref: ref,
              ),
        },
        child: Focus(
          onFocusChange: (value) {
            hasFocus.value = focusNode.hasFocus;
            if (value) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        maxLines: null,
                        focusNode: focusNode,
                        style: context.appTextTheme.bodyMedium,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Talk to myself',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Spacer(),
                    SubmitButton(
                      onPressed: canSubmit.value
                          ? () => _send(
                                textEditingController: textEditingController,
                                ref: ref,
                              )
                          : null,
                    ),
                  ],
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
            ),
            borderRadius: BorderRadius.circular(4),
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
