part of 'chat_view.dart';

/// チャットのTextField。
class _ChatTextField extends HookConsumerWidget {
  const _ChatTextField();

  Future<void> _send({
    required TextEditingController textEditingController,
    required WidgetRef ref,
    required bool todoMode,
  }) async {
    if (textEditingController.text.isEmpty) return;

    // Todoモードの場合、改行でTodoを複数作成する。
    if (todoMode) {
      final titles = textEditingController.text.split('\n');
      await ref.read(
        todoAddControllerProvider(
          titles: titles,
          indexType: TodoAddIndexType.last,
        ).future,
      );
      textEditingController.clear();
      return;
    }

    final provider = appItemControllerProvider;
    ref.read(provider.notifier).addChat(message: textEditingController.text);
    textEditingController.clear();
    FirebaseAnalytics.instance.logEvent(
      name: AnalyticsEventName.addChat.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final hasFocus = useState(false);
    final canSubmit = useState(false);
    final todoMode = useState(false);

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
                todoMode: todoMode.value,
              ),
        },
        child: Focus(
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
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: todoMode.value
                              ? 'New todo list'
                              : 'Talk to myself',
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CheckButton(
                      onPressed: (_) async {
                        todoMode.value = !todoMode.value;
                      },
                      checked: todoMode.value,
                      checkedColor: context.appColors.primary,
                    ),
                    const Spacer(),
                    SubmitButton(
                      onPressed: canSubmit.value
                          ? () => _send(
                                textEditingController: textEditingController,
                                ref: ref,
                                todoMode: todoMode.value,
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
