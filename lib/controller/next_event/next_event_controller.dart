import 'package:quick_flutter/controller/timer/timer_controller.dart';
import 'package:quick_flutter/controller/today_calendar_event/today_calendar_event_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'next_event_controller.g.dart';

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから次のイベントを取得するコントローラー。
///
/// [timerControllerProvider]をwatchしているため、定期的に自動的に更新される。
/// そのため、Widget側でwatchするだけで、自動的に更新される。
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
@riverpod
List<TitleEvent> nextEventController(
  NextEventControllerRef ref,
) {
  ref.watch(timerControllerProvider);
  final now = DateTime.now();
  final events =
      ref.watch(todayCalendarEventControllerProvider).valueOrNull ?? [];

  // startが早い順にソートする
  events.sort((a, b) => a.start.compareTo(b.start));

  return events.where((event) {
    return event.start.isAfter(now);
  }).toList();
}
