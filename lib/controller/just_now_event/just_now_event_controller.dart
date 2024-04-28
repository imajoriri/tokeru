import 'dart:async';

import 'package:quick_flutter/controller/today_calendar_event/today_calendar_event_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'just_now_event_controller.g.dart';

const _justNowEventDuration = Duration(seconds: 30);

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから現在の時間のイベントを取得するコントローラー。
///
/// [_justNowEventDuration]毎に自身をinvalidateするため、watchすると自動的に更新される。
@riverpod
List<TitleEvent> justNowEventController(
  JustNowEventControllerRef ref,
) {
  final timer = Timer(_justNowEventDuration, () {
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
