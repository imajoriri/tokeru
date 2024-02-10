part of 'screen.dart';

class _MemoScreen extends HookConsumerWidget {
  void onUpdateDocument(QuillController controller, WidgetRef ref) {
    var text = controller.document.toPlainText();
    // "[] "パターンを検出して、チェックリストアイテムに置換
    if (text.contains("[] ")) {
      var index = text.indexOf("[] ");
      // チェックリストアイテムに置換
      controller.replaceText(
        index,
        4,
        '',
        TextSelection(
          baseOffset: index,
          extentOffset: index + 4,
          affinity: TextAffinity.downstream,
          isDirectional: false,
        ),
      );

      controller.skipRequestKeyboard = true;
      controller.formatText(index, 0, Attribute.unchecked);
    }
    ref
        .read(memoControllerProvider.notifier)
        .updateDeltaJson(jsonEncode(controller.document.toDelta().toJson()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoAsyncValue = ref.watch(memoControllerProvider);
    final focusNode = useFocusNode();
    final setInitialMemo = useState(false);
    final controller = QuillController.basic();
    controller.changes.listen((event) {
      onUpdateDocument(controller, ref);
    });

    return memoAsyncValue.when(
      skipLoadingOnReload: true,
      data: (memo) {
        // 初回だけ初期値をセットする
        if (!setInitialMemo.value) {
          final document = Document.fromJson(jsonDecode(memo.deltaJson));
          // documentを更新するとlistenが解除されるので再度listenする
          document.changes.listen((data) {
            onUpdateDocument(controller, ref);
          });
          controller.document = document;
          setInitialMemo.value = true;
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
          child: QuillEditor.basic(
            focusNode: focusNode,
            configurations: QuillEditorConfigurations(
              controller: controller,
              readOnly: false,
            ),
          ),
        );
      },
      error: (e, s) {
        return const Center(
          child: Text('エラーが発生しました'),
        );
      },
      loading: () => const SizedBox(),
    );
  }
}
