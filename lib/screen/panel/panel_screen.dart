import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/panel_screen/panel_screen_controller.dart';
import 'package:quick_flutter/utils/panel_method_channel.dart';
import 'package:quick_flutter/widget/button/icon_button.dart';
import 'package:quick_flutter/widget/button/submit_button.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

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
    final focusNode = useFocusNode();

    // ウィンドウをロックしているかどうか。
    final isLocked = useState(false);

    panelMethodChannel.addListnerActive((type) async {
      switch (type) {
        case OsHandlerType.windowActive:
          focusNode.requestFocus();
          break;
        case OsHandlerType.windowInactive:

          // ロックしている場合はウィンドウを閉じない。
          if (!isLocked.value) {
            panelMethodChannel.closeWindow();
          } else {
            // インアクティブの状態で、フォーカスがあると入力できると間違えてしまうので、
            // フォーカスを外す。
            FocusManager.instance.primaryFocus?.unfocus();
          }
          break;
        default:
          break;
      }
    });
    final textEditingConroller = useTextEditingController();
    final canSubmit = useState(textEditingConroller.text.isNotEmpty);

    textEditingConroller.addListener(() {
      canSubmit.value = textEditingConroller.text.isNotEmpty;

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
      physics: const NeverScrollableScrollPhysics(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconButton.small(
                icon: Icon(
                  isLocked.value ? Icons.lock_rounded : Icons.lock_open_rounded,
                ),
                onPressed: () {
                  isLocked.value = !isLocked.value;
                },
                tooltip: '',
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      controller: textEditingConroller,
                      maxLines: null,
                      style: context.appTextTheme.bodyMedium,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SubmitButton(
                    onPressed: canSubmit.value
                        ? () {
                            _send(textEditingConroller, ref);
                          }
                        : null,
                  ),
                ],
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
