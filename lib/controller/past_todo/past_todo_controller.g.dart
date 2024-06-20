// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_todo_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pastTodoControllerHash() =>
    r'e297559d7fa0786ed45b740c2c4af627d5f3f2a7';

/// 昨日以降の[TodoItem]を取得するコントローラー
///
/// Copied from [PastTodoController].
@ProviderFor(PastTodoController)
final pastTodoControllerProvider =
    AsyncNotifierProvider<PastTodoController, List<AppTodoItem>>.internal(
  PastTodoController.new,
  name: r'pastTodoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pastTodoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PastTodoController = AsyncNotifier<List<AppTodoItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
