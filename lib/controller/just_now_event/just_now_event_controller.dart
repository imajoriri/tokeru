import 'dart:async';

import 'package:quick_flutter/controller/today_calendar_event/today_calendar_event_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'just_now_event_controller.g.dart';

const _duration = Duration(seconds: 10);

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから現在の時間のイベントを取得するコントローラー。
///
/// [_duration]毎に自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
@riverpod
List<TitleEvent> justNowEventController(
  JustNowEventControllerRef ref,
) {
  final timer = Timer(_duration, () {
    ref.invalidateSelf();
  });
  ref.onDispose(() => timer.cancel());

  final now = DateTime.now();
  final events =
      ref.watch(todayCalendarEventControllerProvider).valueOrNull ?? [];
  return events.where((event) {
    return event.start.isBefore(now) && event.end.isAfter(now);
  }).toList();
}
