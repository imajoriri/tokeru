// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_add_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoAddControllerHash() => r'd598131115fa9872369bb34e668c9c8f07a92af3';

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
    required int index,
    required String title,
  }) {
    return TodoAddControllerProvider(
      index: index,
      title: title,
    );
  }

  @override
  TodoAddControllerProvider getProviderOverride(
    covariant TodoAddControllerProvider provider,
  ) {
    return call(
      index: provider.index,
      title: provider.title,
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
    required int index,
    required String title,
  }) : this._internal(
          (ref) => todoAddController(
            ref as TodoAddControllerRef,
            index: index,
            title: title,
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
          index: index,
          title: title,
        );

  TodoAddControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
    required this.title,
  }) : super.internal();

  final int index;
  final String title;

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
        index: index,
        title: title,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _TodoAddControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoAddControllerProvider &&
        other.index == index &&
        other.title == title;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoAddControllerRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `index` of this provider.
  int get index;

  /// The parameter `title` of this provider.
  String get title;
}

class _TodoAddControllerProviderElement
    extends AutoDisposeFutureProviderElement<void> with TodoAddControllerRef {
  _TodoAddControllerProviderElement(super.provider);

  @override
  int get index => (origin as TodoAddControllerProvider).index;
  @override
  String get title => (origin as TodoAddControllerProvider).title;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
