part of 'screen.dart';

// ignore: unused_element
class _MemoScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memo = ref.watch(memoControllerProvider);
    final focusNode = useFocusNode();
    final initValue = useState(false);
    final controller =
        useMarkdownTextEditingController(text: memo.valueOrNull?.deltaJson);

    ref.listen(memoControllerProvider, (previous, next) {
      // 初回のみmemoの値をセットする
      if (next.hasValue && !initValue.value) {
        final memo = next.valueOrNull!;
        controller.text = memo.deltaJson;
        initValue.value = true;
      }
    });

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
      child: MarkdownTextField(
        focus: focusNode,
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(8),
          hintText: 'メモを入力',
        ),
        maxLines: null,
        onChanged: (text) {
          ref.read(memoControllerProvider.notifier).updateDeltaJson(text);
        },
      ),
    );
  }
}
