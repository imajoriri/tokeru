import 'package:flutter_test/flutter_test.dart';
import 'package:haptics/haptics.dart';
import 'package:haptics/haptics_platform_interface.dart';
import 'package:haptics/haptics_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHapticsPlatform
    with MockPlatformInterfaceMixin
    implements HapticsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HapticsPlatform initialPlatform = HapticsPlatform.instance;

  test('$MethodChannelHaptics is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHaptics>());
  });

  test('getPlatformVersion', () async {
    Haptics hapticsPlugin = Haptics();
    MockHapticsPlatform fakePlatform = MockHapticsPlatform();
    HapticsPlatform.instance = fakePlatform;

    expect(await hapticsPlugin.getPlatformVersion(), '42');
  });
}
