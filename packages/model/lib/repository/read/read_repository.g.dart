// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$readRepositoryHash() => r'6a47f5797834b69379842090c4153ebe0cfa092b';

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

/// See also [readRepository].
@ProviderFor(readRepository)
const readRepositoryProvider = ReadRepositoryFamily();

/// See also [readRepository].
class ReadRepositoryFamily extends Family {
  /// See also [readRepository].
  const ReadRepositoryFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'readRepositoryProvider';

  /// See also [readRepository].
  ReadRepositoryProvider call(
    String userId,
  ) {
    return ReadRepositoryProvider(
      userId,
    );
  }

  @visibleForOverriding
  @override
  ReadRepositoryProvider getProviderOverride(
    covariant ReadRepositoryProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(ReadRepository Function(ReadRepositoryRef ref) create) {
    return _$ReadRepositoryFamilyOverride(this, create);
  }
}

class _$ReadRepositoryFamilyOverride implements FamilyOverride {
  _$ReadRepositoryFamilyOverride(this.overriddenFamily, this.create);

  final ReadRepository Function(ReadRepositoryRef ref) create;

  @override
  final ReadRepositoryFamily overriddenFamily;

  @override
  ReadRepositoryProvider getProviderOverride(
    covariant ReadRepositoryProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [readRepository].
class ReadRepositoryProvider extends AutoDisposeProvider<ReadRepository> {
  /// See also [readRepository].
  ReadRepositoryProvider(
    String userId,
  ) : this._internal(
          (ref) => readRepository(
            ref as ReadRepositoryRef,
            userId,
          ),
          from: readRepositoryProvider,
          name: r'readRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$readRepositoryHash,
          dependencies: ReadRepositoryFamily._dependencies,
          allTransitiveDependencies:
              ReadRepositoryFamily._allTransitiveDependencies,
          userId: userId,
        );

  ReadRepositoryProvider._internal(
    super.create, {
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
    ReadRepository Function(ReadRepositoryRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReadRepositoryProvider._internal(
        (ref) => create(ref as ReadRepositoryRef),
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
  (String,) get argument {
    return (userId,);
  }

  @override
  AutoDisposeProviderElement<ReadRepository> createElement() {
    return _ReadRepositoryProviderElement(this);
  }

  ReadRepositoryProvider _copyWith(
    ReadRepository Function(ReadRepositoryRef ref) create,
  ) {
    return ReadRepositoryProvider._internal(
      (ref) => create(ref as ReadRepositoryRef),
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      userId: userId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ReadRepositoryProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReadRepositoryRef on AutoDisposeProviderRef<ReadRepository> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _ReadRepositoryProviderElement
    extends AutoDisposeProviderElement<ReadRepository> with ReadRepositoryRef {
  _ReadRepositoryProviderElement(super.provider);

  @override
  String get userId => (origin as ReadRepositoryProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
