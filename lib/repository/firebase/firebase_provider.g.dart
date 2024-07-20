// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDocumentHash() => r'e07fa9fbafa87e3781631bb6b43edbf5c59f9753';

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
class UserDocumentFamily extends Family<DocumentReference> {
  /// See also [userDocument].
  const UserDocumentFamily();

  /// See also [userDocument].
  UserDocumentProvider call(
    String userId,
  ) {
    return UserDocumentProvider(
      userId,
    );
  }

  @override
  UserDocumentProvider getProviderOverride(
    covariant UserDocumentProvider provider,
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
  String? get name => r'userDocumentProvider';
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
    DocumentReference Function(UserDocumentRef provider) create,
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
  ProviderElement<DocumentReference> createElement() {
    return _UserDocumentProviderElement(this);
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
