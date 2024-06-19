// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoUpdateControllerHash() =>
    r'a4d975a080a7d2845a49d68ad23e1248a1477d24';

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

/// [AppTodoItem]の更新を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoUpdateController].
@ProviderFor(todoUpdateController)
const todoUpdateControllerProvider = TodoUpdateControllerFamily();

/// [AppTodoItem]の更新を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoUpdateController].
class TodoUpdateControllerFamily extends Family<AsyncValue<void>> {
  /// [AppTodoItem]の更新を行うController。
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoUpdateController].
  const TodoUpdateControllerFamily();

  /// [AppTodoItem]の更新を行うController。
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoUpdateController].
  TodoUpdateControllerProvider call({
    required InvalidType todo,
  }) {
    return TodoUpdateControllerProvider(
      todo: todo,
    );
  }

  @override
  TodoUpdateControllerProvider getProviderOverride(
    covariant TodoUpdateControllerProvider provider,
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
  String? get name => r'todoUpdateControllerProvider';
}

/// [AppTodoItem]の更新を行うController。
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoUpdateController].
class TodoUpdateControllerProvider extends AutoDisposeFutureProvider<void> {
  /// [AppTodoItem]の更新を行うController。
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoUpdateController].
  TodoUpdateControllerProvider({
    required InvalidType todo,
  }) : this._internal(
          (ref) => todoUpdateController(
            ref as TodoUpdateControllerRef,
            todo: todo,
          ),
          from: todoUpdateControllerProvider,
          name: r'todoUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoUpdateControllerHash,
          dependencies: TodoUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoUpdateControllerFamily._allTransitiveDependencies,
          todo: todo,
        );

  TodoUpdateControllerProvider._internal(
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
    FutureOr<void> Function(TodoUpdateControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodoUpdateControllerProvider._internal(
        (ref) => create(ref as TodoUpdateControllerRef),
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
    return _TodoUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoUpdateControllerProvider && other.todo == todo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoUpdateControllerRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `todo` of this provider.
  InvalidType get todo;
}

class _TodoUpdateControllerProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with TodoUpdateControllerRef {
  _TodoUpdateControllerProviderElement(super.provider);

  @override
  InvalidType get todo => (origin as TodoUpdateControllerProvider).todo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
