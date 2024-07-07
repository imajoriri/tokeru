import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quick_flutter/utils/panel_method_channel.dart';
import 'package:quick_flutter/widget/button/submit_button.dart';

final GlobalKey _childKey = GlobalKey();

class PnaleScreen extends HookWidget {
  const PnaleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textEditingConroller = useTextEditingController();

    textEditingConroller.addListener(() {
      // リビルド後にサイズを取得しないと改行後のサイズが取得できない
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox renderBox =
            _childKey.currentContext!.findRenderObject() as RenderBox;
        final size = renderBox.size;
        panelMethodChannel.resizePanel(height: size.height.toInt());
      });
    });

    // ウィンドウのリサイズが完了するまでにエラーが発生しないように、
    // スクロールできるようにする。
    return SingleChildScrollView(
      child: Padding(
        key: _childKey,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: textEditingConroller,
                maxLines: null,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
            SubmitButton(
              onPressed: () {
                // panelMethodChannel.sendMessage(textEditingConroller.text);
                // textEditingConroller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
