// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_delete_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoDeleteControllerHash() =>
    r'f913d9a21ac908072f93dcd025c12c504a4eb76d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// [AppTodoItem]の削除を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoDeleteController].
@ProviderFor(todoDeleteController)
const todoDeleteControllerProvider = TodoDeleteControllerFamily();

/// [AppTodoItem]の削除を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoDeleteController].
class TodoDeleteControllerFamily extends Family<AsyncValue<void>> {
  /// [AppTodoItem]の削除を行うController。
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoDeleteController].
  const TodoDeleteControllerFamily();

  /// [AppTodoItem]の削除を行うController。
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoDeleteController].
  TodoDeleteControllerProvider call({
    required String todoId,
  }) {
    return TodoDeleteControllerProvider(
      todoId: todoId,
    );
  }

  @override
  TodoDeleteControllerProvider getProviderOverride(
    covariant TodoDeleteControllerProvider provider,
  ) {
    return call(
      todoId: provider.todoId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todoDeleteControllerProvider';
}

/// [AppTodoItem]の削除を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoDeleteController].
class TodoDeleteControllerProvider extends AutoDisposeFutureProvider<void> {
  /// [AppTodoItem]の削除を行うController。
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoDeleteController].
  TodoDeleteControllerProvider({
    required String todoId,
  }) : this._internal(
          (ref) => todoDeleteController(
            ref as TodoDeleteControllerRef,
            todoId: todoId,
          ),
          from: todoDeleteControllerProvider,
          name: r'todoDeleteControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoDeleteControllerHash,
          dependencies: TodoDeleteControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoDeleteControllerFamily._allTransitiveDependencies,
          todoId: todoId,
        );

  TodoDeleteControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todoId,
  }) : super.internal();

  final String todoId;

  @override
  Override overrideWith(
    FutureOr<void> Function(TodoDeleteControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodoDeleteControllerProvider._internal(
        (ref) => create(ref as TodoDeleteControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todoId: todoId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _TodoDeleteControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoDeleteControllerProvider && other.todoId == todoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoDeleteControllerRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `todoId` of this provider.
  String get todoId;
}

class _TodoDeleteControllerProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with TodoDeleteControllerRef {
  _TodoDeleteControllerProviderElement(super.provider);

  @override
  String get todoId => (origin as TodoDeleteControllerProvider).todoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
