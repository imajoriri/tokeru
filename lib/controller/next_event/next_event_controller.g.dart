// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nextEventControllerHash() =>
    r'0c0cbb48936ab0e2fafcfc216055057b60b12719';

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから次のイベントを取得するコントローラー。
///
/// [timerControllerProvider]をwatchしているため、定期的に自動的に更新される。
/// そのため、Widget側でwatchするだけで、自動的に更新される。
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
///
/// Copied from [nextEventController].
@ProviderFor(nextEventController)
final nextEventControllerProvider =
    AutoDisposeProvider<List<TitleEvent>>.internal(
  nextEventController,
  name: r'nextEventControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nextEventControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NextEventControllerRef = AutoDisposeProviderRef<List<TitleEvent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
