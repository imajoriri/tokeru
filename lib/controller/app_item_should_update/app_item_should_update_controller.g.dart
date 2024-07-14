// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_item_should_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appItemShouldUpdateControllerHash() =>
    r'347579dec306fd021d0a0a77a49760422522bdba';

/// [TodayAppItemController]の更新を管理するコントローラー。
///
/// 最終更新日の日をを返す。
/// 以下のタイミングで自信がinvalidateされる。
///
/// - ウィンドウが非アクティブの状態で[AppItem]が更新された場合。
///
/// Copied from [AppItemShouldUpdateController].
@ProviderFor(AppItemShouldUpdateController)
final appItemShouldUpdateControllerProvider =
    NotifierProvider<AppItemShouldUpdateController, DateTime>.internal(
  AppItemShouldUpdateController.new,
  name: r'appItemShouldUpdateControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appItemShouldUpdateControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppItemShouldUpdateController = Notifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
