part of 'main_screen.dart';

/// チャットのTextField。
class _ChatTextField extends HookConsumerWidget {
  const _ChatTextField();

  Future<void> _send({
    required TextEditingController textEditingController,
    required WidgetRef ref,
  }) async {
    if (textEditingController.text.isEmpty) return;

    final provider = todayAppItemControllerProvider;
    ref.read(provider.notifier).addChat(message: textEditingController.text);
    textEditingController.clear();
    FirebaseAnalytics.instance.logEvent(
      name: AnalyticsEventName.addChat.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final baseOffsetIsTop =
        useState(textEditingController.selection.baseOffset == 0);
    final hasFocus = useState(false);
    final canSubmit = useState(false);

    useEffect(
      () {
        textEditingController.addListener(() {
          baseOffsetIsTop.value =
              textEditingController.selection.baseOffset == 0;
          canSubmit.value = textEditingController.text.isNotEmpty;
        });
        return;
      },
      const [],
    );

    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 150));
    final colorTween = ColorTween(
      begin: context.appColors.borderDefault,
      end: context.appColors.borderStrong,
    );
    final shadowColorTween = ColorTween(
      begin: Colors.transparent,
      end: context.appColors.borderStrong.withOpacity(0.2),
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
          // カーソルがテキストの先頭にいる時のみ、上矢印キーでフォーカスを移動する。
          if (baseOffsetIsTop.value)
            const SingleActivator(LogicalKeyboardKey.arrowUp): () {
              if (textEditingController.selection.baseOffset == 0) {
                FocusScope.of(context).previousFocus();
              }
            },
        },
        child: Focus(
          // このWidget全体にフォーカスが当たってしまうため、スキップする。
          // 本来はTextFieldにフォーカスを当てたい。
          focusNode: useFocusNode(skipTraversal: true),
          onFocusChange: (value) {
            hasFocus.value = chatFocusNode.hasFocus;
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
                        focusNode: chatFocusNode,
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
            color: context.appColors.backgroundDefault,
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
