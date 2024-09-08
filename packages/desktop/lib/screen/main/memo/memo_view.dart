import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tokeru_model/controller/global_memo/global_memo.dart';

class MemoView extends HookConsumerWidget {
  const MemoView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          final memo = await ref.read(globalMemoProvider.future);
          textEditingController.text = memo.content;
        });
        return null;
      },
      [],
    );

    return TextField(
      controller: textEditingController,
      onChanged: (value) {
        ref.read(globalMemoProvider.notifier).updateMemo(content: value);
      },
      decoration: InputDecoration(
        hintText: 'メモを入力',
        contentPadding: EdgeInsets.all(8),
      ),
      maxLines: null,
    );
  }
}
