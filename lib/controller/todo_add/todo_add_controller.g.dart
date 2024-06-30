// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_add_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoAddControllerHash() => r'2d095c91333105aa87723c1e562ea5c31aff7519';

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

/// [AppTodoItem]の追加を行うController。
///
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoAddController].
@ProviderFor(todoAddController)
const todoAddControllerProvider = TodoAddControllerFamily();

/// [AppTodoItem]の追加を行うController。
///
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoAddController].
class TodoAddControllerFamily extends Family<AsyncValue<void>> {
  /// [AppTodoItem]の追加を行うController。
  ///
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoAddController].
  const TodoAddControllerFamily();

  /// [AppTodoItem]の追加を行うController。
  ///
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoAddController].
  TodoAddControllerProvider call({
    required List<({int index, String title})> todos,
  }) {
    return TodoAddControllerProvider(
      todos: todos,
    );
  }

  @override
  TodoAddControllerProvider getProviderOverride(
    covariant TodoAddControllerProvider provider,
  ) {
    return call(
      todos: provider.todos,
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
  String? get name => r'todoAddControllerProvider';
}

/// [AppTodoItem]の追加を行うController。
///
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoAddController].
class TodoAddControllerProvider extends AutoDisposeFutureProvider<void> {
  /// [AppTodoItem]の追加を行うController。
  ///
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoAddController].
  TodoAddControllerProvider({
    required List<({int index, String title})> todos,
  }) : this._internal(
          (ref) => todoAddController(
            ref as TodoAddControllerRef,
            todos: todos,
          ),
          from: todoAddControllerProvider,
          name: r'todoAddControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoAddControllerHash,
          dependencies: TodoAddControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoAddControllerFamily._allTransitiveDependencies,
          todos: todos,
        );

  TodoAddControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todos,
  }) : super.internal();

  final List<({int index, String title})> todos;

  @override
  Override overrideWith(
    FutureOr<void> Function(TodoAddControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodoAddControllerProvider._internal(
        (ref) => create(ref as TodoAddControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todos: todos,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _TodoAddControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoAddControllerProvider && other.todos == todos;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todos.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoAddControllerRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `todos` of this provider.
  List<({int index, String title})> get todos;
}

class _TodoAddControllerProviderElement
    extends AutoDisposeFutureProviderElement<void> with TodoAddControllerRef {
  _TodoAddControllerProviderElement(super.provider);

  @override
  List<({int index, String title})> get todos =>
      (origin as TodoAddControllerProvider).todos;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
