import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_flutter/controller/user/user_controller.dart';
import 'package:quick_flutter/model/app_item/app_item.dart';
import 'package:quick_flutter/repository/app_item/app_item_repository.dart';
import 'package:quick_flutter/utils/panel_method_channel.dart';
import 'package:quick_flutter/widget/button/submit_button.dart';
import 'package:uuid/uuid.dart';

final GlobalKey _childKey = GlobalKey();

class PanelScreen extends HookConsumerWidget {
  const PanelScreen({
    super.key,
  });

  Future<void> _send(
      TextEditingController textEditingConroller, WidgetRef ref) async {
    // TODO: リファクタ
    final chat = AppChatItem(
      id: const Uuid().v4(),
      message: textEditingConroller.text,
      createdAt: DateTime.now(),
    );
    final user = await ref.read(userControllerProvider.future);
    final repository = ref.read(appItemRepositoryProvider(user.id));
    try {
      await repository.add(chat);
    } on Exception catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s);
    }
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
          },
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (intent) => _send(textEditingConroller, ref),
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
