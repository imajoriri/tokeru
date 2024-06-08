// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pastTodoControllerHash() =>
    r'84942fb8539c412a5d42f3b242065d532b23f5de';

/// 昨日以降の[TodoItem]を取得するコントローラー
///
/// Copied from [PastTodoController].
@ProviderFor(PastTodoController)
final pastTodoControllerProvider = AutoDisposeAsyncNotifierProvider<
    PastTodoController, List<TodoItem>>.internal(
  PastTodoController.new,
  name: r'pastTodoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pastTodoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PastTodoController = AutoDisposeAsyncNotifier<List<TodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
