// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_todo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updatedTodoHash() => r'6ce20181a0013e4275e39a644d68c0af9db3d7a6';

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
/// Copied from [updatedTodo].
@ProviderFor(updatedTodo)
const updatedTodoProvider = UpdatedTodoFamily();

/// [AppTodoItem]の更新を行うController。
///
/// Copied from [updatedTodo].
class UpdatedTodoFamily extends Family<AsyncValue<AppTodoItem>> {
  /// [AppTodoItem]の更新を行うController。
  ///
  /// Copied from [updatedTodo].
  const UpdatedTodoFamily();

  /// [AppTodoItem]の更新を行うController。
  ///
  /// Copied from [updatedTodo].
  UpdatedTodoProvider call({
    required AppItem todo,
  }) {
    return UpdatedTodoProvider(
      todo: todo,
    );
  }

  @override
  UpdatedTodoProvider getProviderOverride(
    covariant UpdatedTodoProvider provider,
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
  String? get name => r'updatedTodoProvider';
}

/// [AppTodoItem]の更新を行うController。
///
/// Copied from [updatedTodo].
class UpdatedTodoProvider extends AutoDisposeFutureProvider<AppTodoItem> {
  /// [AppTodoItem]の更新を行うController。
  ///
  /// Copied from [updatedTodo].
  UpdatedTodoProvider({
    required AppItem todo,
  }) : this._internal(
          (ref) => updatedTodo(
            ref as UpdatedTodoRef,
            todo: todo,
          ),
          from: updatedTodoProvider,
          name: r'updatedTodoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updatedTodoHash,
          dependencies: UpdatedTodoFamily._dependencies,
          allTransitiveDependencies:
              UpdatedTodoFamily._allTransitiveDependencies,
          todo: todo,
        );

  UpdatedTodoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todo,
  }) : super.internal();

  final AppItem todo;

  @override
  Override overrideWith(
    FutureOr<AppTodoItem> Function(UpdatedTodoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdatedTodoProvider._internal(
        (ref) => create(ref as UpdatedTodoRef),
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
  AutoDisposeFutureProviderElement<AppTodoItem> createElement() {
    return _UpdatedTodoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdatedTodoProvider && other.todo == todo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdatedTodoRef on AutoDisposeFutureProviderRef<AppTodoItem> {
  /// The parameter `todo` of this provider.
  AppItem get todo;
}

class _UpdatedTodoProviderElement
    extends AutoDisposeFutureProviderElement<AppTodoItem> with UpdatedTodoRef {
  _UpdatedTodoProviderElement(super.provider);

  @override
  AppItem get todo => (origin as UpdatedTodoProvider).todo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
