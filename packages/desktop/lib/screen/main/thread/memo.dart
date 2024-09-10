part of 'thread_view.dart';

class _Memo extends HookConsumerWidget {
  const _Memo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(selectedThreadProvider);
    // スレッドが選択されていない場合は何も表示しない。
    if (item == null || item is! AppTodoItem) {
      return const _EmptyState();
    }

    final textEditingController = useTextEditingController(text: item.content);
    useEffect(
      () {
        textEditingController.text = item.content;
        return null;
      },
      [item.id],
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        maxLines: null,
        controller: textEditingController,
        style: context.appTextTheme.bodyMedium,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(8),
        ),
        onChanged: (value) {
          // TODO: debounceする。
          ref.read(selectedThreadProvider.notifier).updateMemo(value);
        },
      ),
    );
  }
}
