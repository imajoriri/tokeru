// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'0f950a6256915bdea0447bfcb02a661ab5c403b3';

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

/// See also [todoRepository].
@ProviderFor(todoRepository)
const todoRepositoryProvider = TodoRepositoryFamily();

/// See also [todoRepository].
class TodoRepositoryFamily extends Family<TodoRepository> {
  /// See also [todoRepository].
  const TodoRepositoryFamily();

  /// See also [todoRepository].
  TodoRepositoryProvider call(
    String userId,
  ) {
    return TodoRepositoryProvider(
      userId,
    );
  }

  @override
  TodoRepositoryProvider getProviderOverride(
    covariant TodoRepositoryProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'todoRepositoryProvider';
}

/// See also [todoRepository].
class TodoRepositoryProvider extends AutoDisposeProvider<TodoRepository> {
  /// See also [todoRepository].
  TodoRepositoryProvider(
    String userId,
  ) : this._internal(
          (ref) => todoRepository(
            ref as TodoRepositoryRef,
            userId,
          ),
          from: todoRepositoryProvider,
          name: r'todoRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoRepositoryHash,
          dependencies: TodoRepositoryFamily._dependencies,
          allTransitiveDependencies:
              TodoRepositoryFamily._allTransitiveDependencies,
          userId: userId,
        );

  TodoRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    TodoRepository Function(TodoRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodoRepositoryProvider._internal(
        (ref) => create(ref as TodoRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<TodoRepository> createElement() {
    return _TodoRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoRepositoryProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoRepositoryRef on AutoDisposeProviderRef<TodoRepository> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _TodoRepositoryProviderElement
    extends AutoDisposeProviderElement<TodoRepository> with TodoRepositoryRef {
  _TodoRepositoryProviderElement(super.provider);

  @override
  String get userId => (origin as TodoRepositoryProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
