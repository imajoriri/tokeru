// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_calendar_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayCalendarEventControllerHash() =>
    r'3e8ff20ff7ff93c47bd53c4d56a5ac5de7a11292';

/// 今日の[TitleEvent]を取得するコントローラー。
///
/// [GoogleSignIn]がログイン済みの場合のみ、イベントを取得します。
/// ログイン状態が変更された場合は、自動的に再取得します。
/// また、24時に自身をinvalidateするため、watchすると自動的に更新される。
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
