import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final methodChannelProvider = Provider<MethodChannel>((ref) {
  return const MethodChannel("quick.flutter/panel");
});

enum AppMethodChannel {
  /// メインウィンドウを左に移動
  windowToLeft,

  /// メインウィンドウを右に移動
  windowToRight,

  alwaysFloatingOn,
  alwaysFloatingOff;
}
