// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerControllerHash() => r'68de1749832a267fa704923496d88554ab0f8ddb';

/// [duration]ごとに自身をinvalidateするコントローラー。
///
/// 定期的に更新したいWidgetで使用する。
/// [_duration]毎に自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
///
/// Copied from [timerController].
@ProviderFor(timerController)
final timerControllerProvider = AutoDisposeProvider<Timer>.internal(
  timerController,
  name: r'timerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TimerControllerRef = AutoDisposeProviderRef<Timer>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
