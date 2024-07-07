import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final methodChannelProvider = Provider<MethodChannel>((ref) {
  return const MethodChannel("quick.flutter/panel");
});

enum AppMethodChannel {
  /// アプリを終了する。
  quit,

  /// パネルを開く。
  openPanel,
  ;
}
