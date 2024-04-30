import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_controller.g.dart';

const _duration = Duration(seconds: 5);

/// [duration]ごとに自身をinvalidateするコントローラー。
///
/// 定期的に更新したいWidgetで使用する。
/// [_duration]毎に自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
@riverpod
Timer timerController(
  TimerControllerRef ref,
) {
  final timer = Timer(_duration, () {
    ref.invalidateSelf();
  });
  ref.onDispose(() => timer.cancel());
  return timer;
}
