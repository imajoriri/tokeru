// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$nextEventControllerHash() =>
    r'5d831be39be1a65ac87c982f0c16702de492bf1f';

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから次のイベントを取得するコントローラー。
///
/// [_duration]毎に自身をinvalidateするため、
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
