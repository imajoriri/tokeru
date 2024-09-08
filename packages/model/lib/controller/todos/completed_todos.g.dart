// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_todos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$completedTodosHash() => r'ea2d238e17a8ee19d0261731700a015e029e3005';

/// 未完了の[AppTodoItem]を返すController。
///
/// ユーザーがログインしていない場合は空を返す。
///
/// Copied from [CompletedTodos].
@ProviderFor(CompletedTodos)
final completedTodosProvider = AutoDisposeStreamNotifierProvider<CompletedTodos,
    List<AppTodoItem>>.internal(
  CompletedTodos.new,
  name: r'completedTodosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedTodosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CompletedTodos = AutoDisposeStreamNotifier<List<AppTodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
