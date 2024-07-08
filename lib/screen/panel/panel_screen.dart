import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/panel_screen/panel_screen_controller.dart';
import 'package:quick_flutter/utils/panel_method_channel.dart';
import 'package:quick_flutter/widget/button/submit_button.dart';

final GlobalKey _childKey = GlobalKey();

class PanelScreen extends HookConsumerWidget {
  const PanelScreen({
    super.key,
  });

  Future<void> _send(
    TextEditingController textEditingConroller,
    WidgetRef ref,
  ) async {
    ref.read(panelScreenControllerProvider.notifier).send(
          message: textEditingConroller.text,
        );
    textEditingConroller.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: FocusableActionDetector(
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.enter, meta: true):
                ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.escape): _CloseWindowIntent(),
          },
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) => _send(textEditingConroller, ref),
            ),
            _CloseWindowIntent: CallbackAction<_CloseWindowIntent>(
              onInvoke: (intent) => panelMethodChannel.closeWindow(),
            ),
          },
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
                  _send(textEditingConroller, ref);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CloseWindowIntent extends Intent {
  const _CloseWindowIntent();
}
