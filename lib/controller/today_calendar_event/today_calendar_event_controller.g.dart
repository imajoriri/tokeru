// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_calendar_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayCalendarEventControllerHash() =>
    r'2f7e1d1c43c560c2af871322bcb70a57bf654a98';

/// 今日の[TitleEvent]を取得するコントローラー。
///
/// [GoogleSignIn]がログイン済みの場合のみ、イベントを取得します。
/// ログイン状態が変更された場合は、自動的に再取得します。
///
/// Copied from [todayCalendarEventController].
@ProviderFor(todayCalendarEventController)
final todayCalendarEventControllerProvider =
    AutoDisposeFutureProvider<List<TitleEvent>>.internal(
  todayCalendarEventController,
  name: r'todayCalendarEventControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayCalendarEventControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodayCalendarEventControllerRef
    = AutoDisposeFutureProviderRef<List<TitleEvent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
