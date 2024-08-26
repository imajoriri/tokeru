// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_todos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subTodosHash() => r'1ea7e39f9674abc7b5782c6f1a8d430bea297c54';

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

abstract class _$SubTodos
    extends BuildlessAutoDisposeStreamNotifier<List<AppSubTodoItem>> {
  late final String parentId;

  Stream<List<AppSubTodoItem>> build(
    String parentId,
  );
}

/// サブTodoのリストを扱うコントローラー。
///
/// Copied from [SubTodos].
@ProviderFor(SubTodos)
const subTodosProvider = SubTodosFamily();

/// サブTodoのリストを扱うコントローラー。
///
/// Copied from [SubTodos].
class SubTodosFamily extends Family {
  /// サブTodoのリストを扱うコントローラー。
  ///
  /// Copied from [SubTodos].
  const SubTodosFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subTodosProvider';

  /// サブTodoのリストを扱うコントローラー。
  ///
  /// Copied from [SubTodos].
  SubTodosProvider call(
    String parentId,
  ) {
    return SubTodosProvider(
      parentId,
    );
  }

  @visibleForOverriding
  @override
  SubTodosProvider getProviderOverride(
    covariant SubTodosProvider provider,
  ) {
    return call(
      provider.parentId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(SubTodos Function() create) {
    return _$SubTodosFamilyOverride(this, create);
  }
}

class _$SubTodosFamilyOverride implements FamilyOverride {
  _$SubTodosFamilyOverride(this.overriddenFamily, this.create);

  final SubTodos Function() create;

  @override
  final SubTodosFamily overriddenFamily;

  @override
  SubTodosProvider getProviderOverride(
    covariant SubTodosProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// サブTodoのリストを扱うコントローラー。
///
/// Copied from [SubTodos].
class SubTodosProvider extends AutoDisposeStreamNotifierProviderImpl<SubTodos,
    List<AppSubTodoItem>> {
  /// サブTodoのリストを扱うコントローラー。
  ///
  /// Copied from [SubTodos].
  SubTodosProvider(
    String parentId,
  ) : this._internal(
          () => SubTodos()..parentId = parentId,
          from: subTodosProvider,
          name: r'subTodosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subTodosHash,
          dependencies: SubTodosFamily._dependencies,
          allTransitiveDependencies: SubTodosFamily._allTransitiveDependencies,
          parentId: parentId,
        );

  SubTodosProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
  }) : super.internal();

  final String parentId;

  @override
  Stream<List<AppSubTodoItem>> runNotifierBuild(
    covariant SubTodos notifier,
  ) {
    return notifier.build(
      parentId,
    );
  }

  @override
  Override overrideWith(SubTodos Function() create) {
    return ProviderOverride(
      origin: this,
      override: SubTodosProvider._internal(
        () => create()..parentId = parentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
      ),
    );
  }

  @override
  (String,) get argument {
    return (parentId,);
  }

  @override
  AutoDisposeStreamNotifierProviderElement<SubTodos, List<AppSubTodoItem>>
      createElement() {
    return _SubTodosProviderElement(this);
  }

  SubTodosProvider _copyWith(
    SubTodos Function() create,
  ) {
    return SubTodosProvider._internal(
      () => create()..parentId = parentId,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      parentId: parentId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubTodosProvider && other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubTodosRef
    on AutoDisposeStreamNotifierProviderRef<List<AppSubTodoItem>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _SubTodosProviderElement extends AutoDisposeStreamNotifierProviderElement<
    SubTodos, List<AppSubTodoItem>> with SubTodosRef {
  _SubTodosProviderElement(super.provider);

  @override
  String get parentId => (origin as SubTodosProvider).parentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
