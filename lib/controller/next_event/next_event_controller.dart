import 'dart:async';

import 'package:quick_flutter/controller/today_calendar_event/today_calendar_event_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'next_event_controller.g.dart';

const _duration = Duration(seconds: 10);

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから次のイベントを取得するコントローラー。
///
/// [_duration]毎に自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
@riverpod
List<TitleEvent> nextEventController(
  NextEventControllerRef ref,
) {
  final timer = Timer(_duration, () {
    ref.invalidateSelf();
  });
  ref.onDispose(() => timer.cancel());

  final now = DateTime.now();
  final events =
      ref.watch(todayCalendarEventControllerProvider).valueOrNull ?? [];

  // startが早い順にソートする
  events.sort((a, b) => a.start.compareTo(b.start));

  return events.where((event) {
    return event.start.isAfter(now);
  }).toList();
}
