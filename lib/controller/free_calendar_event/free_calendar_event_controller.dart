import 'dart:async';

import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'free_calendar_event_controller.g.dart';

/// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
///
/// [duration]ごとに自身をinvalidateするため、watchすると自動的に更新される。
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
  // イベントを開始時間でソート
  events.sort((a, b) => a.start.compareTo(b.start));

  List<FreeEvent> freeTimes = [];

  // startの時刻より前のイベントを削除
  events.removeWhere((element) {
    return element.end.isBefore(start);
  });

  // 時間が被っているイベントがある場合、短い方を削除
  for (int i = 0; i < events.length - 1; i++) {
    for (int j = i + 1; j < events.length; j++) {
      if (events[i].start.isBefore(events[j].end) &&
          events[j].start.isBefore(events[i].end)) {
        if (events[i].duration > events[j].duration) {
          events.removeAt(j);
        } else {
          events.removeAt(i);
        }
      }
    }
  }

  // startの時刻がイベントの中にあるかどうか
  final startIsEventNow = events.indexWhere((element) {
        return start.isAfter(element.start) && start.isBefore(element.end);
      }) !=
      -1;

  // startの時刻がイベント中ではない場合、startから最初のイベントまでの空き時間を追加
  if (events.isNotEmpty && !startIsEventNow) {
    freeTimes.add(FreeEvent(start: start, end: events.first.start));
  }

  // 各イベント間の空き時間を計算
  for (int i = 0; i < events.length - 1; i++) {
    // イベントの終了時刻が次のイベントの開始時刻より前の場合、空き時間を追加
    if (events[i].end.isBefore(events[i + 1].start)) {
      freeTimes.add(FreeEvent(start: events[i].end, end: events[i + 1].start));
    }
  }

  // 最後のイベントから今日の終了時刻まで
  if (events.isNotEmpty && events.last.end.isBefore(end)) {
    freeTimes.add(FreeEvent(start: events.last.end, end: end));
  }

  // イベントがない場合は、全日が空き時間
  if (events.isEmpty) {
    freeTimes.add(FreeEvent(start: start, end: end));
  }

  return freeTimes;
}
