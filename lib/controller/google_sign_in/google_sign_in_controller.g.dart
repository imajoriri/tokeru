// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sign_in_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$googleSignInControllerHash() =>
    r'bc50290076e764e24dd00c0a42d033e93c1001da';

/// [GoogleSignIn]を取得するためのコントローラー。
///
/// 呼び出しと同時に[GoogleSignIn.signInSilently]を実行し、
/// すでにログイン済みの場合はその情報を取得する。
///
/// Copied from [GoogleSignInController].
@ProviderFor(GoogleSignInController)
final googleSignInControllerProvider = AutoDisposeAsyncNotifierProvider<
    GoogleSignInController, GoogleSignInState>.internal(
  GoogleSignInController.new,
  name: r'googleSignInControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$googleSignInControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GoogleSignInController = AutoDisposeAsyncNotifier<GoogleSignInState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
