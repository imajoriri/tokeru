part of 'todo_view.dart';

class _ListModeButtons extends ConsumerWidget {
  const _ListModeButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listMode = ref.watch(listModeProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
      child: Row(
        children: [
          AppTextButton.small(
            onPressed: () async {
              ref.read(listModeProvider.notifier).change(ListModeType.todo);
            },
            text: const Text('To-Do'),
            buttonType: listMode == ListModeType.todo
                ? AppTextButtonType.textSelected
                : AppTextButtonType.textNotSelected,
          ),
          const SizedBox(width: 4),
          AppTextButton.small(
            onPressed: () async {
              ref.read(listModeProvider.notifier).change(ListModeType.done);
            },
            text: const Text('Completed'),
            buttonType: listMode == ListModeType.done
                ? AppTextButtonType.textSelected
                : AppTextButtonType.textNotSelected,
          ),
        ],
      ),
    );
  }
}
