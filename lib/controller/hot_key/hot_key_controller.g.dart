// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_key_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hotKeyControllerHash() => r'512a0771ccd3428f1baf16751f272cd525930ae1';

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
