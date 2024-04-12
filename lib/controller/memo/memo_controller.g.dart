// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memoControllerHash() => r'bb166001a76120115afeaf0a9470016b7dce0346';

/// Userに紐づく[Memo]を返すController
///
/// ユーザーがログインしていない場合は、[Memo]は空の状態で返す。
///
/// Copied from [MemoController].
@ProviderFor(MemoController)
final memoControllerProvider =
    AsyncNotifierProvider<MemoController, Memo>.internal(
  MemoController.new,
  name: r'memoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$memoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MemoController = AsyncNotifier<Memo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
