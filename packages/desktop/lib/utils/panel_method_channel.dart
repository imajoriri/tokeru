import 'package:flutter/services.dart';

/// パネルのMethodChannel。
const panelMethodChannel = _PanelMethodChannel();

class _PanelMethodChannel {
  const _PanelMethodChannel();

  static const _panelMethodChannel = MethodChannel("quick.flutter/panel");

  /// パネルのサイズを変更する。
  Future<void> resizePanel({int? width, int? height}) async {
    await _panelMethodChannel
        .invokeMethod(_AppPanelMethodChannelType.resizePanel.name, {
      if (width != null) "width": width,
      if (height != null) "height": height,
    });
  }

  /// ウィンドウを閉じる。
  Future<void> closeWindow() async {
    await _panelMethodChannel
        .invokeMethod(_AppPanelMethodChannelType.close.name);
  }

  /// activeの通知を受け取る。
  void addListner(Future<dynamic> Function(OsHandlerType) handler) {
    _panelMethodChannel.setMethodCallHandler((call) async {
      final type = OsHandlerType.fromString(call.method);
      if (type != null) {
        handler.call(type);
      }
      return null;
    });
  }
}

/// OS側からの通知の種類。
enum OsHandlerType {
  /// ウィンドウがアクティブになった時の通知。
  windowActive(label: "active"),

  /// ウィンドウが非アクティブになった時の通知。
  windowInactive(label: "inactive"),
  ;

  const OsHandlerType({
    required this.label,
  });

  /// OS側から通知として飛んでくる文字列。
  final String label;

  /// OS側からの通知の[String]を[OsHandlerType]に変換する。
  static OsHandlerType? fromString(String value) {
    for (final type in values) {
      if (type.label == value) {
        return type;
      }
    }
    return null;
  }
}

enum _AppPanelMethodChannelType {
  /// パネルのサイズを変更する。
  resizePanel,

  /// ウィンドウを閉じる。
  close,
  ;
}
