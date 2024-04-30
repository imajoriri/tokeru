// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'just_now_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$justNowEventControllerHash() =>
    r'ee050afa4d818db53e881127cf70c05bd56e073d';

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから現在の時間のイベントを取得するコントローラー。
///
/// [timerControllerProvider]をwatchしているため、定期的に自動的に更新される。
/// そのため、Widget側でwatchするだけで、自動的に更新される。
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
///
/// Copied from [justNowEventController].
@ProviderFor(justNowEventController)
final justNowEventControllerProvider =
    AutoDisposeProvider<List<TitleEvent>>.internal(
  justNowEventController,
  name: r'justNowEventControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$justNowEventControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef JustNowEventControllerRef = AutoDisposeProviderRef<List<TitleEvent>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
