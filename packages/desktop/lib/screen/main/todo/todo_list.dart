part of 'todo_view.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    // Todoを一番下や、Enterで1つ下に追加した時にフォーカスを当てるために使用する。
    // フォーカス後、リビルドごとにフォーカスが当たらないようにするために、nullにする。
    final currentFocusIndex = useState<int?>(null);

    return FocusScope(
      node: todoViewFocusNode,
      child: todos.when(
        data: (todos) {
          if (todos.isEmpty) {
            return const _EmptyState();
          }
          return AnimatedReorderableList(
            items: todos,
            padding:
                EdgeInsets.symmetric(horizontal: context.appSpacing.medium),
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final key = ValueKey(todos[index].id);
              final todo = todos[index];
              return _TodoListItem(
                key: key,
                todo: todo,
                index: index,
                currentFocusIndex: currentFocusIndex,
              );
            },
            onReorder: ref.read(todosProvider.notifier).reorder,
            isSameItem: (oldItem, newItem) => oldItem.id == newItem.id,
          );
        },
        error: (e, s) => const Text('Error'),
        loading: () => const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Loading...'),
        ),
      ),
    );
  }
}

class _TodoListItem extends HookConsumerWidget {
  const _TodoListItem({
    super.key,
    required this.todo,
    required this.index,
    required this.currentFocusIndex,
  });

  final AppTodoItem todo;
  final int index;
  final ValueNotifier<int?> currentFocusIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(selectedThreadProvider)?.id == todo.id;
    final textEditingController = useTextEditingController(text: todo.title);
    final focusNode = useFocusNode();
    if (currentFocusIndex.value == index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
        currentFocusIndex.value = null;
      });
    }

    useEffect(
      () {
        focusNode.addListener(() {
          if (focusNode.hasFocus) {
            ref.read(selectedThreadProvider.notifier).open(todo.id);
          }
        });
        return null;
      },
      const [],
    );

    return Padding(
      padding: EdgeInsets.only(bottom: context.appSpacing.smallX),
      child: TodoListItem(
        isSelected: isSelected,
        isDone: todo.isDone,
        focusNode: focusNode,
        index: index,
        textEditingController: textEditingController,
        subTodoCount: todo.subTodoCount,
        onDeleted: () async {
          ref.read(todosProvider.notifier).deleteTodo(todoId: todo.id);
        },
        onUpdatedTitle: (value) {
          ref
              .read(todosProvider.notifier)
              .updateTodoTitle(todoId: todo.id, title: value);
        },
        onToggleDone: (value) {
          ref.read(todosProvider.notifier).toggleTodoDone(todoId: todo.id);
          FirebaseAnalytics.instance.logEvent(
            name: AnalyticsEventName.toggleTodoDone.name,
          );
        },
        focusDown: FocusScope.of(context).nextFocus,
        focusUp: FocusScope.of(context).previousFocus,
        onNewTodoBelow: () async {
          await ref
              .read(todosProvider.notifier)
              .addTodoWithIndex(index: index + 1);
          currentFocusIndex.value = index + 1;
        },
        // 一番上のTodoは上に移動できない
        onSortUp: index != 0
            ? () {
                ref.read(todosProvider.notifier).reorder(index, index - 1);
              }
            : null,
        // 一番下のTodoは下に移動できない
        onSortDown: index != ref.read(todosProvider).valueOrNull!.length - 1
            ? () {
                ref.read(todosProvider.notifier).reorder(index, index + 1);
              }
            : null,
      ),
    );
  }
}

class _EmptyState extends ConsumerWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                color: context.appColors.onSurfaceSubtle,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppTextButton.medium(
              icon: const Icon(AppIcons.add),
              onPressed: () {
                ref.read(todosProvider.notifier).addTodoWithIndex(index: 0);
              },
              text: const Text('Add To-Do'),
            ),
          ],
        ),
      ),
    );
  }
}
