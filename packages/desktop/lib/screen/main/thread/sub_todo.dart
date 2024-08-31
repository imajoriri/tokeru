part of 'thread_view.dart';

class _SubTodoView extends HookConsumerWidget {
  const _SubTodoView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(selectedThreadProvider);
    if (parent == null) {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'No todo selected',
          ),
        ),
      );
    }

    final provider = subTodosProvider(parent.id);
    final subTodos = ref.watch(provider);

    // Todoを一番下や、Enterで1つ下に追加した時にフォーカスを当てるために使用する。
    // フォーカス後、リビルドごとにフォーカスが当たらないようにするために、nullにする。
    final currentFocusIndex = useState<int?>(null);
    return Container(
      padding: EdgeInsets.only(
        left: context.appSpacing.small,
        right: context.appSpacing.small,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: subTodos.when(
              data: (todos) {
                return CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ReorderableListView.builder(
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
                                  .read(provider.notifier)
                                  .reorder(oldIndex, newIndex);
                            },
                            itemBuilder: (context, index) {
                              final key = ValueKey(todos[index].id);
                              final todo = todos[index];
                              return HookBuilder(
                                key: key,
                                builder: (context) {
                                  final focusNode = useFocusNode();
                                  if (currentFocusIndex.value == index) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      focusNode.requestFocus();
                                      currentFocusIndex.value = null;
                                    });
                                  }
                                  final textEditingController =
                                      useTextEditingController(
                                    text: todo.title,
                                  );
                                  return TodoListItem(
                                    isDone: todo.isDone,
                                    index: index,
                                    textEditingController:
                                        textEditingController,
                                    focusNode: focusNode,
                                    onDeleted: () async {
                                      ref
                                          .read(provider.notifier)
                                          .delete(todoId: todo.id);
                                    },
                                    onUpdatedTitle: (value) {
                                      ref.read(provider.notifier).updateTitle(
                                          todoId: todo.id, title: value);
                                    },
                                    onToggleDone: (value) {
                                      ref
                                          .read(provider.notifier)
                                          .toggleDone(todoId: todo.id);
                                    },
                                    focusDown: () {
                                      FocusScope.of(context).nextFocus();
                                    },
                                    focusUp: () {
                                      FocusScope.of(context).previousFocus();
                                    },
                                    onNewTodoBelow: () async {
                                      await ref
                                          .read(provider.notifier)
                                          .addWithIndex(index + 1);
                                      currentFocusIndex.value = index + 1;
                                    },
                                    // 一番上のTodoは上に移動できない
                                    onSortUp: index != 0
                                        ? () {
                                            ref
                                                .read(provider.notifier)
                                                .reorder(index, index - 1);
                                          }
                                        : null,
                                    // 一番下のTodoは下に移動できない
                                    onSortDown: index != todos.length - 1
                                        ? () {
                                            ref
                                                .read(provider.notifier)
                                                .reorder(index, index + 1);
                                          }
                                        : null,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return const SizedBox();
              },
              error: (error, _) {
                return const SizedBox();
              },
            ),
          ),
          Row(
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
                  ref.read(threadsProvider(parent.id).notifier).generateSubTodo(
                        todo: parent as AppTodoItem,
                      );
                },
                text: const Text('Generate with AI'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
