// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDocumentHash() => r'b868d5d223068ca06767224f02cef6a445cef03b';

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

/// See also [userDocument].
@ProviderFor(userDocument)
const userDocumentProvider = UserDocumentFamily();

/// See also [userDocument].
class UserDocumentFamily extends Family {
  /// See also [userDocument].
  const UserDocumentFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userDocumentProvider';

  /// See also [userDocument].
  UserDocumentProvider call(
    String userId,
  ) {
    return UserDocumentProvider(
      userId,
    );
  }

  @visibleForOverriding
  @override
  UserDocumentProvider getProviderOverride(
    covariant UserDocumentProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(
      DocumentReference Function(UserDocumentRef ref) create) {
    return _$UserDocumentFamilyOverride(this, create);
  }
}

class _$UserDocumentFamilyOverride implements FamilyOverride {
  _$UserDocumentFamilyOverride(this.overriddenFamily, this.create);

  final DocumentReference Function(UserDocumentRef ref) create;

  @override
  final UserDocumentFamily overriddenFamily;

  @override
  UserDocumentProvider getProviderOverride(
    covariant UserDocumentProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [userDocument].
class UserDocumentProvider extends Provider<DocumentReference> {
  /// See also [userDocument].
  UserDocumentProvider(
    String userId,
  ) : this._internal(
          (ref) => userDocument(
            ref as UserDocumentRef,
            userId,
          ),
          from: userDocumentProvider,
          name: r'userDocumentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userDocumentHash,
          dependencies: UserDocumentFamily._dependencies,
          allTransitiveDependencies:
              UserDocumentFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserDocumentProvider._internal(
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
    DocumentReference Function(UserDocumentRef ref) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserDocumentProvider._internal(
        (ref) => create(ref as UserDocumentRef),
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
  ProviderElement<DocumentReference> createElement() {
    return _UserDocumentProviderElement(this);
  }

  UserDocumentProvider _copyWith(
    DocumentReference Function(UserDocumentRef ref) create,
  ) {
    return UserDocumentProvider._internal(
      (ref) => create(ref as UserDocumentRef),
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
    return other is UserDocumentProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserDocumentRef on ProviderRef<DocumentReference> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserDocumentProviderElement extends ProviderElement<DocumentReference>
    with UserDocumentRef {
  _UserDocumentProviderElement(super.provider);

  @override
  String get userId => (origin as UserDocumentProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
