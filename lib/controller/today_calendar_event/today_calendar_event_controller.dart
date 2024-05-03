import 'dart:async';

import 'package:googleapis/calendar/v3.dart';
import 'package:quick_flutter/controller/google_sign_in/google_sign_in_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_calendar_event_controller.g.dart';

/// 今日の[TitleEvent]を取得するコントローラー。
///
/// [GoogleSignIn]がログイン済みの場合のみ、イベントを取得します。
/// ログイン状態が変更された場合は、自動的に再取得します。
/// また、24時に自身をinvalidateするため、watchすると自動的に更新される。
@riverpod
Future<List<TitleEvent>> todayCalendarEventController(
  TodayCalendarEventControllerRef ref,
) async {
  final now = DateTime.now();
  final nextDay = DateTime.now().add(const Duration(days: 1));
  final nextDayStart =
      DateTime(nextDay.year, nextDay.month, nextDay.day, 0, 0, 1);
  // 24時に自信をinvalidateする
  final duration = nextDayStart.difference(now);
  final timer = Timer(
    duration,
    () => ref.invalidateSelf(),
  );
  ref.onDispose(() => timer.cancel());

  final googleSignIn = ref.watch(googleSignInControllerProvider).valueOrNull;
  if (googleSignIn == null) {
    return [];
  }

  if (!googleSignIn.isSignIn) {
    return [];
  }

  final calendarApi = CalendarApi(googleSignIn.client!);

  final todayStart = DateTime(now.year, now.month, now.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  final ids = ['primary', "takeyuki.imajo@soda-inc.jp"];
  final calEvents = <Event>[];
  for (final id in ids) {
    final events = await calendarApi.events.list(
      id,
      timeMin: todayStart,
      timeMax: todayEnd,
      singleEvents: true,
    );
    calEvents.addAll(events.items ?? []);
  }

  // startがnullの場合、終日イベントなので除外する
  calEvents.removeWhere((element) => element.start?.dateTime == null);

  final result = calEvents.map((e) {
    return TitleEvent(
      title: e.summary ?? '',
      start: e.start?.dateTime?.toLocal() ?? DateTime.now(),
      end: e.end?.dateTime?.toLocal() ?? DateTime.now(),
    );
  }).toList();
  return result;
}
