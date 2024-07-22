// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoControllerHash() => r'6da571197307aca6a026c43d9457425f346de51d';

/// 未完了の[AppTodoItem]を返すController。
///
/// ユーザーがログインしていない場合は空を返す。
///
/// Copied from [TodoController].
@ProviderFor(TodoController)
final todoControllerProvider =
    StreamNotifierProvider<TodoController, List<AppTodoItem>>.internal(
  TodoController.new,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoController = StreamNotifier<List<AppTodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
