// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_done_todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayDoneTodoControllerHash() =>
    r'1034b58b6dba0c870bcc42cf312dc28f07fd6cc6';

/// 今日作成された完了済みの[AppTodoItem]を返すController
///
/// [todayAppItemControllerProvider]を監視すしているため、[todayAppItemControllerProvider]が更新されると、
/// このControllerも更新される。
///
/// Copied from [TodayDoneTodoController].
@ProviderFor(TodayDoneTodoController)
final todayDoneTodoControllerProvider =
    AsyncNotifierProvider<TodayDoneTodoController, List<AppTodoItem>>.internal(
  TodayDoneTodoController.new,
  name: r'todayDoneTodoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayDoneTodoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodayDoneTodoController = AsyncNotifier<List<AppTodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
