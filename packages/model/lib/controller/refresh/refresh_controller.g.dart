// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$refreshControllerHash() => r'196079fe3021e8cd5993334c31dfe3a726fa2b31';

/// アプリ内のデータを更新するためのコントローラー。
///
/// 「Cmd + R」でこのProviderがinvalidateされ、watchしているProviderも更新されることを
/// 想定している。
/// 最新更新日を返す。
/// このコントローラーをref.watchすることで、データの更新を行う。
///
/// Copied from [RefreshController].
@ProviderFor(RefreshController)
final refreshControllerProvider =
    NotifierProvider<RefreshController, DateTime>.internal(
  RefreshController.new,
  name: r'refreshControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$refreshControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RefreshController = Notifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
