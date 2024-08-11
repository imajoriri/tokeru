import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'haptics_platform_interface.dart';

/// An implementation of [HapticsPlatform] that uses method channels.
class MethodChannelHaptics extends HapticsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('haptics');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
