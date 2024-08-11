import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'haptics_method_channel.dart';

abstract class HapticsPlatform extends PlatformInterface {
  /// Constructs a HapticsPlatform.
  HapticsPlatform() : super(token: _token);

  static final Object _token = Object();

  static HapticsPlatform _instance = MethodChannelHaptics();

  /// The default instance of [HapticsPlatform] to use.
  ///
  /// Defaults to [MethodChannelHaptics].
  static HapticsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HapticsPlatform] when
  /// they register themselves.
  static set instance(HapticsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
