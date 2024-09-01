part of 'thread_view.dart';

/// サブタスクの追加ボタン。
class _AddSubTodoButton extends ConsumerWidget {
  const _AddSubTodoButton({
    required this.currentFocusIndex,
  });

  final ValueNotifier<int?> currentFocusIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider);
    final provider = subTodosProvider(parent!.id);
    final subTodos = ref.watch(provider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.appSpacing.small),
      child: Row(
        children: [
          AppTextButton.medium(
            onPressed: () async {
              // Todoを一番下に追加する
              await ref
                  .read(provider.notifier)
                  .addWithIndex(subTodos.valueOrNull?.length ?? 0);
              currentFocusIndex.value = subTodos.valueOrNull?.length ?? 0;
            },
            text: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                SizedBox(width: 4),
                Text('Add sub todo'),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AppTextButton.medium(
            onPressed: () async {
              final parent = ref.watch(selectedThreadProvider) as AppTodoItem;
              final provider =
                  generativeSubTodoProvider(parentTodoTitle: parent.title);
              ref.read(provider.notifier).generateSubTodo();
            },
            text: const Text('Generate with AI'),
          ),
        ],
      ),
    );
  }
}
