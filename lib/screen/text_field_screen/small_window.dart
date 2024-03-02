part of 'screen.dart';

class _SmallWindow extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(todoControllerProvider);
    const index = 0;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ref.read(windowSizeModeControllerProvider.notifier).toLarge();
      },
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: asyncValue.when(
          data: (todos) {
            if (todos.isEmpty) {
              return SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(todoControllerProvider.notifier).add(0);
                    ref
                        .read(windowSizeModeControllerProvider.notifier)
                        .toLarge();
                  },
                  child: const Text("追加"),
                ),
              );
            }
            final todo = todos[index];
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                children: [
                  Checkbox(
                    value: todo.isDone,
                    onChanged: (value) async {
                      await ref
                          .read(todoControllerProvider.notifier)
                          .updateIsDone(index);
                    },
                    focusNode: useFocusNode(
                      skipTraversal: true,
                    ),
                  ),
                  Text(todo.title),
                ],
              ),
            );
          },
          error: (e, s) => const SizedBox(),
          loading: () => const SizedBox(),
        ),
      ),
    );
  }
}
