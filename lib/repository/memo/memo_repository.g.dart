// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memoRepositoryHash() => r'ee6a10fb83558b2a4123c2a65bebabb70a75c263';

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

/// See also [memoRepository].
@ProviderFor(memoRepository)
const memoRepositoryProvider = MemoRepositoryFamily();

/// See also [memoRepository].
class MemoRepositoryFamily extends Family<MemoRepository> {
  /// See also [memoRepository].
  const MemoRepositoryFamily();

  /// See also [memoRepository].
  MemoRepositoryProvider call(
    String userId,
  ) {
    return MemoRepositoryProvider(
      userId,
    );
  }

  @override
  MemoRepositoryProvider getProviderOverride(
    covariant MemoRepositoryProvider provider,
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
  String? get name => r'memoRepositoryProvider';
}

/// See also [memoRepository].
class MemoRepositoryProvider extends AutoDisposeProvider<MemoRepository> {
  /// See also [memoRepository].
  MemoRepositoryProvider(
    String userId,
  ) : this._internal(
          (ref) => memoRepository(
            ref as MemoRepositoryRef,
            userId,
          ),
          from: memoRepositoryProvider,
          name: r'memoRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$memoRepositoryHash,
          dependencies: MemoRepositoryFamily._dependencies,
          allTransitiveDependencies:
              MemoRepositoryFamily._allTransitiveDependencies,
          userId: userId,
        );

  MemoRepositoryProvider._internal(
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
    MemoRepository Function(MemoRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MemoRepositoryProvider._internal(
        (ref) => create(ref as MemoRepositoryRef),
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
  AutoDisposeProviderElement<MemoRepository> createElement() {
    return _MemoRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MemoRepositoryProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MemoRepositoryRef on AutoDisposeProviderRef<MemoRepository> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _MemoRepositoryProviderElement
    extends AutoDisposeProviderElement<MemoRepository> with MemoRepositoryRef {
  _MemoRepositoryProviderElement(super.provider);

  @override
  String get userId => (origin as MemoRepositoryProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
