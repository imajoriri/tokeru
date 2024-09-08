part of 'thread_view.dart';

/// サブタスクの追加ボタン。
class _AddSubTodoButton extends ConsumerWidget {
  const _AddSubTodoButton({
    required this.currentFocusIndex,
    required this.isDone,
  });

  final ValueNotifier<int?> currentFocusIndex;
  final ValueNotifier<bool> isDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider) as AppTodoItem;
    final provider = subTodosProvider(
      parentId: parent.id,
      isDone: false,
    );
    final subTodos = ref.watch(provider);
    final generativeProvider =
        generativeSubTodoProvider(parentTodoTitle: parent.title);

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
            icon: const Icon(AppIcons.add),
            text: const Text('Add sub todo'),
          ),
          const SizedBox(width: 8),
          AppTextButton.medium(
            onPressed: () async {
              ref.read(generativeProvider.notifier).generateSubTodo();
            },
            text: const Text('Generate with AI'),
            isLoading: ref.watch(generativeProvider).isLoading,
          ),
          const Spacer(),
          AppTextButton.small(
            onPressed: () async {
              isDone.value = !isDone.value;
            },
            buttonType: AppTextButtonType.textSubtle,
            text: isDone.value
                ? const Text('show todos')
                : const Text('show completed'),
          ),
        ],
      ),
    );
  }
}
