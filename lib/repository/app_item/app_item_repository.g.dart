// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_item_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appItemRepositoryHash() => r'10d884deea45ee7f0ea34e2438490be68f195add';

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

/// [TodoItem]を扱うRepository
///
/// Copied from [appItemRepository].
@ProviderFor(appItemRepository)
const appItemRepositoryProvider = AppItemRepositoryFamily();

/// [TodoItem]を扱うRepository
///
/// Copied from [appItemRepository].
class AppItemRepositoryFamily extends Family<AppItemRepository> {
  /// [TodoItem]を扱うRepository
  ///
  /// Copied from [appItemRepository].
  const AppItemRepositoryFamily();

  /// [TodoItem]を扱うRepository
  ///
  /// Copied from [appItemRepository].
  AppItemRepositoryProvider call(
    String userId,
  ) {
    return AppItemRepositoryProvider(
      userId,
    );
  }

  @override
  AppItemRepositoryProvider getProviderOverride(
    covariant AppItemRepositoryProvider provider,
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
  String? get name => r'appItemRepositoryProvider';
}

/// [TodoItem]を扱うRepository
///
/// Copied from [appItemRepository].
class AppItemRepositoryProvider extends AutoDisposeProvider<AppItemRepository> {
  /// [TodoItem]を扱うRepository
  ///
  /// Copied from [appItemRepository].
  AppItemRepositoryProvider(
    String userId,
  ) : this._internal(
          (ref) => appItemRepository(
            ref as AppItemRepositoryRef,
            userId,
          ),
          from: appItemRepositoryProvider,
          name: r'appItemRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appItemRepositoryHash,
          dependencies: AppItemRepositoryFamily._dependencies,
          allTransitiveDependencies:
              AppItemRepositoryFamily._allTransitiveDependencies,
          userId: userId,
        );

  AppItemRepositoryProvider._internal(
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
    AppItemRepository Function(AppItemRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AppItemRepositoryProvider._internal(
        (ref) => create(ref as AppItemRepositoryRef),
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
  AutoDisposeProviderElement<AppItemRepository> createElement() {
    return _AppItemRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppItemRepositoryProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AppItemRepositoryRef on AutoDisposeProviderRef<AppItemRepository> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _AppItemRepositoryProviderElement
    extends AutoDisposeProviderElement<AppItemRepository>
    with AppItemRepositoryRef {
  _AppItemRepositoryProviderElement(super.provider);

  @override
  String get userId => (origin as AppItemRepositoryProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
