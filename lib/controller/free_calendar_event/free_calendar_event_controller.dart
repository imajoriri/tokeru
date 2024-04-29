import 'dart:async';

import 'package:collection/collection.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'free_calendar_event_controller.g.dart';

/// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
///
/// [duration]ごとに自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
/// [events]が空の場合は、全日が空き時間となる。
@riverpod
List<FreeEvent> freeCalendarEventController(
  FreeCalendarEventControllerRef ref,
  List<TitleEvent> events,
  DateTime start,
  DateTime end,
  Duration duration,
) {
  final timer = Timer(duration, () {
    ref.invalidateSelf();
  });
  ref.onDispose(() => timer.cancel());
  return _findFreeTimes(events: events, start: start, end: end);
}

/// [TitleEvent]のリストから[FreeEvent]のリストを取得する。
List<FreeEvent> _findFreeTimes({
  required List<TitleEvent> events,
  required DateTime start,
  required DateTime end,
}) {
  List<FreeEvent> freeTimes = [];

  // イベントがない場合は、全日が空き時間
  if (events.isEmpty) {
    return [FreeEvent(start: start, end: end)];
  }

  // start ~ end間にないイベントを削除
  events.removeWhere((element) {
    return element.end.isBefore(start) || element.start.isAfter(end);
  });

  // イベントを開始時間でソート
  events.sort((a, b) => a.start.compareTo(b.start));

  // 全く同じ時間のイベントを削除する
  events = events.where((event) {
    return events.indexWhere((event2) {
          return event.start == event2.start && event.end == event2.end;
        }) ==
        events.indexOf(event);
  }).toList();

  // 終了時刻が同じイベントがある場合、期間が短い方を削除する
  events.removeWhere((event) {
    return events.indexWhere((event2) {
          return event.start.isAfter(event2.start) &&
              event.end.isAtSameMomentAs(event2.end);
        }) !=
        -1;
  });

  // 開始時刻が同じイベントがある場合、期間が短い方を削除する
  events.removeWhere((event) {
    return events.indexWhere((event2) {
          return event.start.isAtSameMomentAs(event2.start) &&
              event.end.isBefore(event2.end);
        }) !=
        -1;
  });

  // start と endの擬似イベントを追加
  events.insert(0, TitleEvent(title: 'start', start: start, end: start));
  events.add(TitleEvent(title: 'end', start: end, end: end));

  for (int i = 0; i < events.length - 1; i++) {
    final event = events[i];
    // eventの終了時刻よりstartが前で、eventの終了時刻よりendが後のイベントが他にある場合
    // 何もしない
    if (events.indexWhere((event2) {
          return event.end.isAfter(event2.start) &&
              event.end.isBefore(event2.end);
        }) !=
        -1) {
      continue;
    }

    // eventの終了時刻よりstartが後のEventがある場合、
    // eventの終了時刻からstartまでの空き時間を追加
    final nextEvent = events.firstWhereOrNull((event2) {
      return (event.end.isBefore(event2.start) ||
              event.end.isAtSameMomentAs(event2.start)) &&
          // eventと同じ時間のイベントは除外(自身も含まれてしまうため)
          (event.start != event2.start && event.end != event2.end);
    });
    if (nextEvent != null && event.end != nextEvent.start) {
      freeTimes.add(FreeEvent(start: event.end, end: nextEvent.start));
    }
  }
  return freeTimes;
}
