import 'dart:io';

import 'haptics_platform_interface.dart';

/// カスタマイズされたHapticsを実行するクラス。
class TokeruHaptics {
  Future<String?> getPlatformVersion() {
    return HapticsPlatform.instance.getPlatformVersion();
  }

  /// 何かしらの要素にホバーした時のHapticsを実行する。
  ///
  /// macOSのトラックパットのみで動作する。
  void hovered() {
    if (Platform.isMacOS) {
      HapticsPlatform.instance.hovered();
    }
  }
}
