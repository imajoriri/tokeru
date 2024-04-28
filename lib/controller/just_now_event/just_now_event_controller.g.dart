// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'just_now_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$justNowEventControllerHash() =>
    r'd2b017ab9d2c3c300ed53d39bfdc913c2f9ba2ee';

/// [todayCalendarEventControllerProvider]の[TitleEvent]のリストから現在の時間のイベントを取得するコントローラー。
///
/// [_justNowEventDuration]毎に自身をinvalidateするため、watchすると自動的に更新される。
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
