import 'package:flutter/services.dart';

const mainMethodChannel = _MainMethodChannel();

class _MainMethodChannel {
  const _MainMethodChannel();

  static const _mainMethodChannel = MethodChannel("quick.flutter/window");

  /// アプリを終了する。
  Future<void> quit() async {
    await _mainMethodChannel.invokeMethod(_AppMethodChannelType.quit.name);
  }

  /// パネルを開く。
  Future<void> openPanel() async {
    await _mainMethodChannel.invokeMethod(_AppMethodChannelType.openPanel.name);
  }

  /// activeの通知を受け取る。
  void addListnerActive(Future<dynamic> Function(MethodCall)? handler) {
    _mainMethodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'inactive':
          break;
        case 'active':
          handler?.call(call);
          break;
      }
      return null;
    });
  }
}

enum _AppMethodChannelType {
  /// アプリを終了する。
  quit,

  /// パネルを開く。
  openPanel,
}
