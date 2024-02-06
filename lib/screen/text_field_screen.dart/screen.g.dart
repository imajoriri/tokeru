// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarkControllerHash() =>
    r'03ce89f2a876574cc0f1caa78e22e85620eb3cee';

/// See also [BookmarkController].
@ProviderFor(BookmarkController)
final bookmarkControllerProvider =
    NotifierProvider<BookmarkController, bool>.internal(
  BookmarkController.new,
  name: r'bookmarkControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarkControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookmarkController = Notifier<bool>;
String _$todoControllerHash() => r'e115144038eba7ab95a09b1b55694de1b825a28d';

/// See also [TodoController].
@ProviderFor(TodoController)
final todoControllerProvider =
    AsyncNotifierProvider<TodoController, List<Todo>>.internal(
  TodoController.new,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoController = AsyncNotifier<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
