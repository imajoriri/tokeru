// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_add_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoAddControllerHash() => r'cdd9c53b4baf1bcc0c1d0ea601fe089df5b6607b';

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

/// [AppTodoItem]を複数追加を行うController。
///
/// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
///
/// todos:
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

/// [AppTodoItem]を複数追加を行うController。
///
/// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
///
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoAddController].
class TodoAddControllerFamily extends Family<AsyncValue<void>> {
  /// [AppTodoItem]を複数追加を行うController。
  ///
  /// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
  ///
  /// todos:
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoAddController].
  const TodoAddControllerFamily();

  /// [AppTodoItem]を複数追加を行うController。
  ///
  /// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
  ///
  /// todos:
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoAddController].
  TodoAddControllerProvider call({
    required List<String> titles,
    required TodoAddIndexType indexType,
  }) {
    return TodoAddControllerProvider(
      titles: titles,
      indexType: indexType,
    );
  }

  @override
  TodoAddControllerProvider getProviderOverride(
    covariant TodoAddControllerProvider provider,
  ) {
    return call(
      titles: provider.titles,
      indexType: provider.indexType,
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

/// [AppTodoItem]を複数追加を行うController。
///
/// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
///
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [todoAddController].
class TodoAddControllerProvider extends AutoDisposeFutureProvider<void> {
  /// [AppTodoItem]を複数追加を行うController。
  ///
  /// 複数の[Todo]を一度に追加するために、Recordを受け取っている。
  ///
  /// todos:
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [todoAddController].
  TodoAddControllerProvider({
    required List<String> titles,
    required TodoAddIndexType indexType,
  }) : this._internal(
          (ref) => todoAddController(
            ref as TodoAddControllerRef,
            titles: titles,
            indexType: indexType,
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
          titles: titles,
          indexType: indexType,
        );

  TodoAddControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.titles,
    required this.indexType,
  }) : super.internal();

  final List<String> titles;
  final TodoAddIndexType indexType;

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
        titles: titles,
        indexType: indexType,
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
        other.titles == titles &&
        other.indexType == indexType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, titles.hashCode);
    hash = _SystemHash.combine(hash, indexType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoAddControllerRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `titles` of this provider.
  List<String> get titles;

  /// The parameter `indexType` of this provider.
  TodoAddIndexType get indexType;
}

class _TodoAddControllerProviderElement
    extends AutoDisposeFutureProviderElement<void> with TodoAddControllerRef {
  _TodoAddControllerProviderElement(super.provider);

  @override
  List<String> get titles => (origin as TodoAddControllerProvider).titles;
  @override
  TodoAddIndexType get indexType =>
      (origin as TodoAddControllerProvider).indexType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
