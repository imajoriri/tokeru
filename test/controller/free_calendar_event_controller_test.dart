import 'package:flutter_test/flutter_test.dart';
import 'package:quick_flutter/controller/free_calendar_event/free_calendar_event_controller.dart';
import 'package:quick_flutter/model/calendar_event/calendar_event.dart';

import 'create_container.dart';

void main() {
  group('freeCalendarEventController', () {
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

    test('startがイベントとかぶっていない場合、startの時刻からフリータイムを計算する', () async {
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
          DateTime(2021, 1, 1, 9, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 9, 0),
            end: DateTime(2021, 1, 1, 10, 0),
          ),
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

    test('endがイベントとかぶっている場合、最後のイベントの end までをフリータイムとする', () async {
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
          DateTime(2021, 1, 1, 14, 0),
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
        ],
      );
    });

    test('endがイベントとかぶっていない場合、 end までをフリータイムとする', () async {
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

    test('endがイベントとかぶっていない場合、 end までをフリータイムとする', () async {
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

    test('2つのイベントが完全にかぶっている場合、 短いイベントは無視される', () async {
      final container = createContainer();
      final freeEvents = container.read(
        freeCalendarEventControllerProvider(
          [
            TitleEvent(
              title: 'event1',
              start: DateTime(2021, 1, 1, 10, 0),
              end: DateTime(2021, 1, 1, 11, 0),
            ),
            TitleEvent(
              title: 'event2',
              start: DateTime(2021, 1, 1, 9, 0),
              end: DateTime(2021, 1, 1, 12, 0),
            ),
          ],
          DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 8, 0),
            end: DateTime(2021, 1, 1, 9, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 12, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );

      // eventsを逆にしても同じ結果が返る
      final freeEvents2 = container.read(
        freeCalendarEventControllerProvider(
          [
            TitleEvent(
              title: 'event2',
              start: DateTime(2021, 1, 1, 9, 0),
              end: DateTime(2021, 1, 1, 12, 0),
            ),
            TitleEvent(
              title: 'event1',
              start: DateTime(2021, 1, 1, 10, 0),
              end: DateTime(2021, 1, 1, 11, 0),
            ),
          ],
          DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents2,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 8, 0),
            end: DateTime(2021, 1, 1, 9, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 12, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );
    });

    test('2つのイベントがかぶっているが、片方が片方に完全に被っているわけではない場合', () async {
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
              start: DateTime(2021, 1, 1, 11, 0),
              end: DateTime(2021, 1, 1, 14, 0),
            ),
          ],
          DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 8, 0),
            end: DateTime(2021, 1, 1, 10, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 14, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );

      final freeEvents2 = container.read(
        freeCalendarEventControllerProvider(
          [
            TitleEvent(
              title: 'event2',
              start: DateTime(2021, 1, 1, 11, 0),
              end: DateTime(2021, 1, 1, 14, 0),
            ),
            TitleEvent(
              title: 'event1',
              start: DateTime(2021, 1, 1, 10, 0),
              end: DateTime(2021, 1, 1, 12, 0),
            ),
          ],
          DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents2,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 8, 0),
            end: DateTime(2021, 1, 1, 10, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 14, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );
    });

    test('連続している2つのイベントがある場合', () async {
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
              start: DateTime(2021, 1, 1, 12, 0),
              end: DateTime(2021, 1, 1, 14, 0),
            ),
          ],
          DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 8, 0),
            end: DateTime(2021, 1, 1, 10, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 14, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );
    });

    test('全く同じ時間の2つのイベントがある場合', () async {
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
              start: DateTime(2021, 1, 1, 10, 0),
              end: DateTime(2021, 1, 1, 12, 0),
            ),
          ],
          DateTime(2021, 1, 1, 8, 0),
          DateTime(2021, 1, 1, 16, 0),
          const Duration(hours: 1),
        ),
      );

      expect(
        freeEvents,
        [
          FreeEvent(
            start: DateTime(2021, 1, 1, 8, 0),
            end: DateTime(2021, 1, 1, 10, 0),
          ),
          FreeEvent(
            start: DateTime(2021, 1, 1, 12, 0),
            end: DateTime(2021, 1, 1, 16, 0),
          ),
        ],
      );
    });
  });
}
