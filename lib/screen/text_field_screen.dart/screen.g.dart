// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarkControllerHash() =>
    r'8057b39d0205bc4dbbe9c442ee54c67322059ce3';

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
String _$todoControllerHash() => r'f4ddca19a246d84601fc0904c1825e952b8ada30';

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
