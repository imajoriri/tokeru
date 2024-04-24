import 'package:flutter_test/flutter_test.dart';
import 'package:quick_flutter/controller/free_calendar_event/free_calendar_event_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';

import 'create_container.dart';

void main() {
  group('freeCalendarEventController', () {
    // startがイベントとかぶっている場合
    // startがイベントとかぶってない場合
    // endがイベントとかぶっている場合
    // endがイベントとかぶってない場合

    // 2つのイベントがかぶっていない場合
    // 2つのイベントが完全にかぶっている場合
    // 2つのイベントがかぶっているが、被っていない時間もある場合
    test('startがイベントとかぶっている場合、最初のイベントの終了時刻からフリータイムを計算する', () async {
      final container = createContainer();
      final freeEvents = container.read(
        freeCalendarEventControllerProvider(
          [
            TitleEvent(
              title: 'event1',
              start: DateTime(2021, 1, 1, 10, 0),
              end: DateTime(2021, 1, 1, 12, 0),
            ),
            TitleEvent(
              title: 'event2',
              start: DateTime(2021, 1, 1, 13, 0),
              end: DateTime(2021, 1, 1, 15, 0),
            ),
          ],
          DateTime(2021, 1, 1, 11, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 12, 0),
            end: DateTime(2021, 1, 1, 13, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 15, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );
    });
  });
}
