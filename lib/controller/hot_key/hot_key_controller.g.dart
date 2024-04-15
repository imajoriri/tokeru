// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_key_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hotKeyControllerHash() => r'7072d5d8238210f41f73f29753de596b1aa1c494';

/// アプリを起動するためのホットキーを登録するController
///
/// Copied from [HotKeyController].
@ProviderFor(HotKeyController)
final hotKeyControllerProvider = AutoDisposeAsyncNotifierProvider<
    HotKeyController, List<PhysicalKeyboardKey>>.internal(
  HotKeyController.new,
  name: r'hotKeyControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hotKeyControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HotKeyController
    = AutoDisposeAsyncNotifier<List<PhysicalKeyboardKey>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
