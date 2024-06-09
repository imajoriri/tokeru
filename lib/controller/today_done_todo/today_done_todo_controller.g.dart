// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_done_todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayDoneTodoControllerHash() =>
    r'ab014b420082e2dd7aa304bf93316fd798616e8c';

/// 今日作成された完了済みの[TodoItem]を返すController
///
/// Copied from [TodayDoneTodoController].
@ProviderFor(TodayDoneTodoController)
final todayDoneTodoControllerProvider =
    AsyncNotifierProvider<TodayDoneTodoController, List<TodoItem>>.internal(
  TodayDoneTodoController.new,
  name: r'todayDoneTodoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayDoneTodoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodayDoneTodoController = AsyncNotifier<List<TodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
