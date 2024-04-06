part of 'screen.dart';

/// 新規Todoを追加するためのTextField
class _TodoTextField extends HookConsumerWidget {
  const _TodoTextField({Key? key}) : super(key: key);

  /// todoを最後に追加し、テキストを空にする
  void _addTodo(
    WidgetRef ref,
    TextEditingController controller,
    FocusNode focusNode,
  ) {
    final lastIndex = ref.read(todoControllerProvider).valueOrNull?.length;
    ref
        .read(todoControllerProvider.notifier)
        .add(lastIndex ?? 0, title: controller.text);
    controller.clear();
    ref.read(memoControllerProvider.notifier).updateContent('');

    FirebaseAnalytics.instance.logEvent(
      name: AnalyticsEventName.addTodo.name,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = useState(false);
    final baseOffset = useState(0);

    final controller = useTextEditingController();
    final focusNode = ref.watch(todoTextFieldFocusControllerProvider);

    useEffect(
      () {
        controller.addListener(() {
          canSubmit.value = controller.text.isNotEmpty;
          baseOffset.value = controller.selection.baseOffset;
        });

        return null;
      },
      [],
    );

    // Memoの読み込み時毎回データをセットしているとリビルドされてフォーカスが外れてしまうため
    // 初回のみmemoの値をセットする
    final setInitValue = useState(false);
    useEffect(
      () {
        ref.listen(memoControllerProvider, (previous, next) {
          if (next.hasValue && !setInitValue.value) {
            final memo = next.valueOrNull!;
            controller.text = memo.content;
            setInitValue.value = true;
          }
        });

        return null;
      },
      [],
    );

    return Actions(
      actions: {
        // カーソルがテキストの一番最初にある場合のみ、フォーカスを一つ上に移動する
        if (baseOffset.value == 0)
          FocusUpIntent: ref.read(todoFucusLastActionProvider),
      },
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.enter, meta: true): () {
            if (canSubmit.value) {
              _addTodo(ref, controller, focusNode);
            }
          },
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a new todo or memo...',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  onChanged: (text) {
                    ref
                        .read(memoControllerProvider.notifier)
                        .updateContent(text);
                  },
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                color: context.colorScheme.primary,
                onPressed: canSubmit.value
                    ? () {
                        _addTodo(ref, controller, focusNode);
                      }
                    : null,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
