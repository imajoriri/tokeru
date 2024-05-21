// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoControllerHash() => r'2babc5d76555b732f6ce4df703da8b14a78f9f23';

/// 今日作成された[TodoItem]を返すController
///
/// ユーザーがログインしていない場合は、[TodoItem]は空の状態で返す。
///
/// Copied from [TodoController].
@ProviderFor(TodoController)
final todoControllerProvider =
    AsyncNotifierProvider<TodoController, List<TodoItem>>.internal(
  TodoController.new,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoController = AsyncNotifier<List<TodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
