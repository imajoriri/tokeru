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
}

enum _AppPanelMethodChannelType {
  /// パネルのサイズを変更する。
  resizePanel,
  ;
}