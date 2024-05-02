part of 'todo_screen.dart';

class _TodaySection extends HookConsumerWidget {
  const _TodaySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayCalendarEvent = ref.watch(todayCalendarEventControllerProvider);
    final googleSignIn = ref.watch(googleSignInControllerProvider);

    return switch ((todayCalendarEvent, googleSignIn)) {
      // `todayCalendarEvent`か`googleSignIn`がどちらかがローディングであれば、ローディング中を表示
      (AsyncLoading(), _) || (_, AsyncLoading()) => const _LoadingView(),
      (AsyncData(), AsyncData()) =>
        _FreeTimes(titleEvents: todayCalendarEvent.value!),
      _ => const SizedBox(),
    };
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your free time today...",
            style: context.appTextTheme.labelLarge
                .copyWith(color: context.appColors.textSubtle),
          ),
          const SizedBox(height: 4),
          Text("__:__", style: context.appTextTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _FreeTimes extends HookConsumerWidget {
  const _FreeTimes({
    required this.titleEvents,
  });

  final List<TitleEvent> titleEvents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final justNowEvents = ref.watch(justNowEventControllerProvider);
    final hasJustNowEvents = justNowEvents.isNotEmpty;
    final freeTimeStatus =
        hasJustNowEvents ? _FreeTimeStatus.busy : _FreeTimeStatus.free;
    final start = DateTime.now();
    final end = DateTime(start.year, start.month, start.day, 23, 59, 59);
    final freeEvents = ref.watch(
      freeCalendarEventControllerProvider(
        titleEvents,
        start,
        end,
        const Duration(minutes: 1),
      ),
    );
    // 残りの分数
    final freeTimeMinitues = freeEvents.fold(
      0,
      (previousValue, element) => previousValue + element.duration.inMinutes,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your free time today...",
            style: context.appTextTheme.labelLarge
                .copyWith(color: context.appColors.textSubtle),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _StatusIcon(
                status: hasJustNowEvents
                    ? _FreeTimeStatus.busy
                    : _FreeTimeStatus.free,
              ),
              const SizedBox(width: 4),
              Text(
                convertToMinutesAndSeconds(freeTimeMinitues),
                style: context.appTextTheme.bodyLarge,
              ),
              const SizedBox(width: 8),
              switch (freeTimeStatus) {
                _FreeTimeStatus.free => const _NextEvent(),
                _FreeTimeStatus.busy => const _JustNowEvent(),
              },
            ],
          ),
        ],
      ),
    );
  }

  /// 分数を分:秒の形式に変換する
  String convertToMinutesAndSeconds(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}"; // 分:秒の形式で返す
  }
}

/// フリータイムのステータス
enum _FreeTimeStatus {
  /// フリータイム
  free,

  /// カレンダーイベント
  busy,
}

/// [status]によって色が変わる、8pxの丸い円を表示する。
class _StatusIcon extends StatelessWidget {
  const _StatusIcon({
    required this.status,
  });

  final _FreeTimeStatus status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: switch (status) {
            _FreeTimeStatus.free => context.appColors.eventInProgress,
            _FreeTimeStatus.busy => context.appColors.eventStop,
          },
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// 次のイベントを表示する
class _NextEvent extends HookConsumerWidget {
  const _NextEvent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextEvents = ref.watch(nextEventControllerProvider);
    final event = nextEvents.firstOrNull;
    if (event == null) {
      return const SizedBox();
    }

    // スタートまでの時間
    final now = DateTime.now();
    final duration = event.start.difference(now);
    final minutes = duration.inMinutes;

    final title = event.title.isEmpty ? 'busy' : event.title;

    return Text(
      '(Next is "$title" in ${minutes}min)',
      style: context.appTextTheme.bodyMedium,
    );
  }
}

/// 現在進行中のイベントを表示する
class _JustNowEvent extends HookConsumerWidget {
  const _JustNowEvent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final justNowEvents = ref.watch(justNowEventControllerProvider);
    final event = justNowEvents.firstOrNull;
    if (event == null) {
      return const SizedBox();
    }

    final title = event.title.isEmpty ? 'busy' : event.title;

    return Text(
      '("$title" is ${event.start.hour}:${event.start.minute} ~ ${event.end.hour}:${event.end.minute})',
      style: context.appTextTheme.bodyMedium,
    );
  }
}
