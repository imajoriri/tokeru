// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_todos.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subTodosHash() => r'0bcafe604ca331fd177d3cc68cca52198634c1d1';

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
  late final bool isDone;

  Stream<List<AppSubTodoItem>> build({
    required String parentId,
    required bool isDone,
  });
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
  SubTodosProvider call({
    required String parentId,
    required bool isDone,
  }) {
    return SubTodosProvider(
      parentId: parentId,
      isDone: isDone,
    );
  }

  @visibleForOverriding
  @override
  SubTodosProvider getProviderOverride(
    covariant SubTodosProvider provider,
  ) {
    return call(
      parentId: provider.parentId,
      isDone: provider.isDone,
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
  SubTodosProvider({
    required String parentId,
    required bool isDone,
  }) : this._internal(
          () => SubTodos()
            ..parentId = parentId
            ..isDone = isDone,
          from: subTodosProvider,
          name: r'subTodosProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subTodosHash,
          dependencies: SubTodosFamily._dependencies,
          allTransitiveDependencies: SubTodosFamily._allTransitiveDependencies,
          parentId: parentId,
          isDone: isDone,
        );

  SubTodosProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
    required this.isDone,
  }) : super.internal();

  final String parentId;
  final bool isDone;

  @override
  Stream<List<AppSubTodoItem>> runNotifierBuild(
    covariant SubTodos notifier,
  ) {
    return notifier.build(
      parentId: parentId,
      isDone: isDone,
    );
  }

  @override
  Override overrideWith(SubTodos Function() create) {
    return ProviderOverride(
      origin: this,
      override: SubTodosProvider._internal(
        () => create()
          ..parentId = parentId
          ..isDone = isDone,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
        isDone: isDone,
      ),
    );
  }

  @override
  ({
    String parentId,
    bool isDone,
  }) get argument {
    return (
      parentId: parentId,
      isDone: isDone,
    );
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
      () => create()
        ..parentId = parentId
        ..isDone = isDone,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      parentId: parentId,
      isDone: isDone,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SubTodosProvider &&
        other.parentId == parentId &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);
    hash = _SystemHash.combine(hash, isDone.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubTodosRef
    on AutoDisposeStreamNotifierProviderRef<List<AppSubTodoItem>> {
  /// The parameter `parentId` of this provider.
  String get parentId;

  /// The parameter `isDone` of this provider.
  bool get isDone;
}

class _SubTodosProviderElement extends AutoDisposeStreamNotifierProviderElement<
    SubTodos, List<AppSubTodoItem>> with SubTodosRef {
  _SubTodosProviderElement(super.provider);

  @override
  String get parentId => (origin as SubTodosProvider).parentId;
  @override
  bool get isDone => (origin as SubTodosProvider).isDone;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
