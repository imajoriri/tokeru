// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoControllerHash() => r'e909557c04b5fe5868575ce53b330a184b312d8f';

/// 今日作成された[AppTodoItem]を返すController
///
/// ユーザーがログインしていない場合は空を返す。
///
/// Copied from [TodoController].
@ProviderFor(TodoController)
final todoControllerProvider =
    AsyncNotifierProvider<TodoController, List<AppTodoItem>>.internal(
  TodoController.new,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoController = AsyncNotifier<List<AppTodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
