// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userControllerHash() => r'a1b9ad0ea7282a8e4534ade45772622b237ea37b';

/// ログインしているユーザーを取得する
///
/// Firebase authentication の匿名ログインを行い、ログインしているユーザーを取得します。
/// ログインしていない場合は匿名ログインを行います。
///
/// Copied from [userController].
@ProviderFor(userController)
final userControllerProvider = FutureProvider<User>.internal(
  userController,
  name: r'userControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserControllerRef = FutureProviderRef<User>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
