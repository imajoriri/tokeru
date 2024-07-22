// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_todo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newTodoHash() => r'0b1f3fcd3a9ecba859b0a2ac4ed1c228b7226fe0';

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
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [newTodo].
@ProviderFor(newTodo)
const newTodoProvider = NewTodoFamily();

/// [AppTodoItem]の追加を行うController。
///
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [newTodo].
class NewTodoFamily extends Family<AsyncValue<AppTodoItem?>> {
  /// [AppTodoItem]の追加を行うController。
  ///
  /// todos:
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [newTodo].
  const NewTodoFamily();

  /// [AppTodoItem]の追加を行うController。
  ///
  /// todos:
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [newTodo].
  NewTodoProvider call({
    String title = '',
    required TodoAddIndexType indexType,
  }) {
    return NewTodoProvider(
      title: title,
      indexType: indexType,
    );
  }

  @override
  NewTodoProvider getProviderOverride(
    covariant NewTodoProvider provider,
  ) {
    return call(
      title: provider.title,
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
  String? get name => r'newTodoProvider';
}

/// [AppTodoItem]の追加を行うController。
///
/// todos:
/// - index: [TodoController]に追加する位置
/// - title: 追加する[AppTodoItem]のタイトル
///
/// 以下のControllerのstateも更新する。
/// - [TodayAppItemController]
/// - [TodoController]
///
/// Copied from [newTodo].
class NewTodoProvider extends AutoDisposeFutureProvider<AppTodoItem?> {
  /// [AppTodoItem]の追加を行うController。
  ///
  /// todos:
  /// - index: [TodoController]に追加する位置
  /// - title: 追加する[AppTodoItem]のタイトル
  ///
  /// 以下のControllerのstateも更新する。
  /// - [TodayAppItemController]
  /// - [TodoController]
  ///
  /// Copied from [newTodo].
  NewTodoProvider({
    String title = '',
    required TodoAddIndexType indexType,
  }) : this._internal(
          (ref) => newTodo(
            ref as NewTodoRef,
            title: title,
            indexType: indexType,
          ),
          from: newTodoProvider,
          name: r'newTodoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$newTodoHash,
          dependencies: NewTodoFamily._dependencies,
          allTransitiveDependencies: NewTodoFamily._allTransitiveDependencies,
          title: title,
          indexType: indexType,
        );

  NewTodoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.title,
    required this.indexType,
  }) : super.internal();

  final String title;
  final TodoAddIndexType indexType;

  @override
  Override overrideWith(
    FutureOr<AppTodoItem?> Function(NewTodoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NewTodoProvider._internal(
        (ref) => create(ref as NewTodoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        title: title,
        indexType: indexType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AppTodoItem?> createElement() {
    return _NewTodoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NewTodoProvider &&
        other.title == title &&
        other.indexType == indexType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);
    hash = _SystemHash.combine(hash, indexType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NewTodoRef on AutoDisposeFutureProviderRef<AppTodoItem?> {
  /// The parameter `title` of this provider.
  String get title;

  /// The parameter `indexType` of this provider.
  TodoAddIndexType get indexType;
}

class _NewTodoProviderElement
    extends AutoDisposeFutureProviderElement<AppTodoItem?> with NewTodoRef {
  _NewTodoProviderElement(super.provider);

  @override
  String get title => (origin as NewTodoProvider).title;
  @override
  TodoAddIndexType get indexType => (origin as NewTodoProvider).indexType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
