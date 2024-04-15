import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:quick_flutter/controller/method_channel/method_channel_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hot_key_controller.g.dart';

/// アプリを起動するためのホットキーを登録するController
@riverpod
class HotKeyController extends _$HotKeyController {
  @override
  Future<List<PhysicalKeyboardKey>> build() async {
    HotKey hotKey = HotKey(
      key: PhysicalKeyboardKey.comma,
      modifiers: [HotKeyModifier.meta, HotKeyModifier.shift],
    );
    hotKeyManager.register(
      hotKey,
      keyDownHandler: (hotKey) {
        final channel = ref.watch(methodChannelProvider);
        channel.invokeMethod(AppMethodChannel.openOrClosePanel.name);
      },
    );
    return [
      PhysicalKeyboardKey.comma,
    ];
  }
}
