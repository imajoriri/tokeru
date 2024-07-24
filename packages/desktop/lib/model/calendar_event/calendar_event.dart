/// カレンダーのイベントを表すクラス
sealed class CalendarEvent {
  const CalendarEvent(
    this.start,
    this.end,
  );

  /// イベントの開始時刻
  final DateTime start;

  /// イベントの終了時刻
  final DateTime end;

  /// イベントの時間の長さ
  Duration get duration => end.difference(start);
}

/// タイトルがあるイベントを表すクラス
class TitleEvent extends CalendarEvent {
  const TitleEvent({
    required this.title,
    required DateTime start,
    required DateTime end,
  }) : super(start, end);

  /// イベントのタイトル
  final String title;
}

/// 空白のイベントを表すクラス
///
/// Google Calendarのイベントがない時間を表す
class FreeEvent extends CalendarEvent {
  const FreeEvent({
    required DateTime start,
    required DateTime end,
  }) : super(start, end);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is FreeEvent && start == other.start && end == other.end);
  }
}
