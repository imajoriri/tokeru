part of 'main_screen.dart';

class _TodoSction extends HookConsumerWidget {
  const _TodoSction();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoControllerProvider);
    return todos.when(
      data: (todos) {
        if (todos.isEmpty) {
          return const _EmptyState();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TodoList
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
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
                  final key = ValueKey(todos[index].id);
                  final todo = todos[index];
                  return HookBuilder(
                    key: key,
                    builder: (context) {
                      return TodoListItem(
                        todo: todo,
                        index: index,
                        focusNode:
                            ref.watch(todoFocusControllerProvider)[index],
                        controller:
                            useTodoTextEditingController(text: todo.title),
                        onDeleted: () async {
                          final currentFocusIndex = ref
                              .read(todoFocusControllerProvider.notifier)
                              .getFocusIndex();
                          await ref.read(
                            todoDeleteControllerProvider(todoId: todo.id)
                                .future,
                          );
                          ref
                              .read(todoFocusControllerProvider.notifier)
                              .requestFocus(currentFocusIndex - 1);
                        },
                        onUpdatedTitle: (value) {
                          ref.read(
                            todoUpdateControllerProvider(
                              todo: todo.copyWith(title: value),
                            ).future,
                          );
                        },
                        onToggleDone: (value) {
                          ref.read(
                            todoUpdateControllerProvider(
                              todo: todo.copyWith(isDone: value ?? false),
                            ).future,
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
                          await ref.read(
                            todoAddControllerProvider(
                              titles: [''],
                              indexType: TodoAddIndexType.current,
                            ).future,
                          );
                        },
                        // 一番上のTodoは上に移動できない
                        onSortUp: index != 0
                            ? () {
                                final focusController = ref
                                    .read(todoFocusControllerProvider.notifier);
                                focusController.removeFocus();
                                ref
                                    .read(todoControllerProvider.notifier)
                                    .reorder(index, index - 1);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  focusController.requestFocus(index - 1);
                                });
                              }
                            : null,
                        // 一番下のTodoは下に移動できない
                        onSortDown: index !=
                                ref
                                        .read(todoControllerProvider)
                                        .valueOrNull!
                                        .length -
                                    1
                            ? () {
                                final focusController = ref
                                    .read(todoFocusControllerProvider.notifier);
                                focusController.removeFocus();
                                ref
                                    .read(todoControllerProvider.notifier)
                                    .reorder(index, index + 1);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  focusController.requestFocus(index + 1);
                                });
                              }
                            : null,
                      );
                    },
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Actions.handler<NewTodoIntent>(
        context,
        const NewTodoIntent(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        width: double.infinity,
        child: Column(
          children: [
            TextButtonSmall(
              onPressed: () {
                Actions.handler<NewTodoIntent>(
                  context,
                  const NewTodoIntent(),
                );
              },
              child: const Text('Add To-Do'),
            ),
          ],
        ),
      ),
    );
  }
}
