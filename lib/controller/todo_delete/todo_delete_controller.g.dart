// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_delete_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoDeleteControllerHash() =>
    r'17f8c98e58c1a457c92bc8e6d776cd60ed1e1f01';

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
    required InvalidType todo,
  }) {
    return TodoDeleteControllerProvider(
      todo: todo,
    );
  }

  @override
  TodoDeleteControllerProvider getProviderOverride(
    covariant TodoDeleteControllerProvider provider,
  ) {
    return call(
      todo: provider.todo,
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
    required InvalidType todo,
  }) : this._internal(
          (ref) => todoDeleteController(
            ref as TodoDeleteControllerRef,
            todo: todo,
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
          todo: todo,
        );

  TodoDeleteControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todo,
  }) : super.internal();

  final InvalidType todo;

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
        todo: todo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _TodoDeleteControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoDeleteControllerProvider && other.todo == todo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoDeleteControllerRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `todo` of this provider.
  InvalidType get todo;
}

class _TodoDeleteControllerProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with TodoDeleteControllerRef {
  _TodoDeleteControllerProviderElement(super.provider);

  @override
  InvalidType get todo => (origin as TodoDeleteControllerProvider).todo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
