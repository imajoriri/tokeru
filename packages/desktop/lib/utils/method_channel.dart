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
  void addListnerActive(Future<dynamic> Function(MainOsHandlerType) handler) {
    _mainMethodChannel.setMethodCallHandler((call) async {
      final type = MainOsHandlerType.fromString(call.method);
      if (type != null) {
        handler.call(type);
      }
      return null;
    });
  }
}

/// OS側からの通知の種類。
enum MainOsHandlerType {
  /// ウィンドウがアクティブになった時の通知。
  windowActive(label: "active"),

  /// ウィンドウが非アクティブになった時の通知。
  windowInactive(label: "inactive"),
  ;

  const MainOsHandlerType({
    required this.label,
  });

  /// OS側から通知として飛んでくる文字列。
  final String label;

  /// OS側からの通知の[String]を[OsHandlerType]に変換する。
  static MainOsHandlerType? fromString(String value) {
    for (final type in values) {
      if (type.label == value) {
        return type;
      }
    }
    return null;
  }
}

enum _AppMethodChannelType {
  /// アプリを終了する。
  quit,

  /// パネルを開く。
  openPanel,
}
