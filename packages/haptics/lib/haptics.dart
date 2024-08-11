import 'haptics_platform_interface.dart';

/// カスタマイズされたHapticsを実行するクラス。
class Haptics {
  Future<String?> getPlatformVersion() {
    return HapticsPlatform.instance.getPlatformVersion();
  }
}
