// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$refreshControllerHash() => r'05b489a5be0af9d7bf6434b59c54ecf5c20ab7b2';

/// データを更新するためのコントローラー。
///
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
