part of 'todo_view.dart';

class TodayTodoList extends HookConsumerWidget {
  const TodayTodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return GestureDetector(
            onTap: Actions.handler<NewTodoIntent>(
              context,
              const NewTodoIntent(),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'There are no To-Dos for today.\nPlease start by clicking here or pressing Command + N.',
                    style: context.appTextTheme.bodySmall.copyWith(
                      color: context.appColors.textSubtle,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: Actions.handler<NewTodoIntent>(
                      context,
                      const NewTodoIntent(),
                    ),
                    child: const Text('Add To-Do'),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Today's To-Dos",
                style: context.appTextTheme.titleSmall,
              ),
            ),

            // TodoList
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ReorderableListView.builder(
                buildDefaultDragHandles: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: todos.length,
                onReorder: (oldIndex, newIndex) {
                  // NOTE: なぜか上から下に移動するときはnewIndexが1つずれるので
                  // その分を補正する
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  ref
                      .read(todoControllerProvider.notifier)
                      .reorder(oldIndex, newIndex);
                },
                itemBuilder: (context, index) {
                  final key = Key(todos[index].id);
                  return _ReorderableTodoListItem(
                    key: key,
                    todo: todos[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        );
      },
      error: (e, s) => const Text('Error'),
      loading: () => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Loading...'),
      ),
    );
  }
}

/// [ReorderableListView]の中で使う[Todo]のリスト
class _ReorderableTodoListItem extends HookConsumerWidget {
  const _ReorderableTodoListItem({
    super.key,
    required this.todo,
    required this.index,
  });

  /// リストのindex
  final int index;

  /// Todo
  final AppTodoItem todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TodoListItem(
      todo: todo,
      index: index,
      focusNode: ref.watch(todoFocusControllerProvider)[index],
      controller: useTextEditingController(text: todo.title),
      onDeleted: () async {
        final currentFocusIndex =
            ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
        await ref.read(todoControllerProvider.notifier).delete(todo);
        ref
            .read(todoFocusControllerProvider.notifier)
            .requestFocus(currentFocusIndex - 1);
      },
      onUpdatedTitle: (value) => ref
          .read(todoControllerProvider.notifier)
          .updateTodoTitle(todoId: todo.id, title: value),
      onToggleDone: (value) {
        ref.read(todoControllerProvider.notifier).updateIsDone(
              todoId: todo.id,
              isDone: value ?? false,
            );
        FirebaseAnalytics.instance.logEvent(
          name: AnalyticsEventName.toggleTodoDone.name,
        );
      },
      focusDown: () {
        FocusScope.of(context).nextFocus();
      },
      focusUp: () {
        FocusScope.of(context).previousFocus();
      },
      onNewTodoBelow: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final index =
            ref.read(todoFocusControllerProvider.notifier).getFocusIndex();
        await ref.read(todoControllerProvider.notifier).add(index + 1);
        await ref.read(todoControllerProvider.notifier).updateCurrentOrder();
        ref.read(todoFocusControllerProvider)[index + 1].requestFocus();
      },
      // 一番上のTodoは上に移動できない
      onSortUp: index != 0
          ? () {
              final focusController =
                  ref.read(todoFocusControllerProvider.notifier);
              focusController.removeFocus();
              ref
                  .read(todoControllerProvider.notifier)
                  .reorder(index, index - 1);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                focusController.requestFocus(index - 1);
              });
            }
          : null,
      // 一番下のTodoは下に移動できない
      onSortDown:
          index != ref.read(todoControllerProvider).valueOrNull!.length - 1
              ? () {
                  final focusController =
                      ref.read(todoFocusControllerProvider.notifier);
                  focusController.removeFocus();
                  ref
                      .read(todoControllerProvider.notifier)
                      .reorder(index, index + 1);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    focusController.requestFocus(index + 1);
                  });
                }
              : null,
    );
  }
}
