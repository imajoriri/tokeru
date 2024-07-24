// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_items.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appItemsHash() => r'c6e9f67838cc06fc0c883958546ed06bdf07092e';

/// See also [AppItems].
@ProviderFor(AppItems)
final appItemsProvider =
    AutoDisposeAsyncNotifierProvider<AppItems, List<AppItem>>.internal(
  AppItems.new,
  name: r'appItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppItems = AutoDisposeAsyncNotifier<List<AppItem>>;
String _$appItemsPaginationHash() =>
    r'3415793ceea13dfa18d645fa86032d11b7adba5e';

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

abstract class _$AppItemsPagination
    extends BuildlessAutoDisposeNotifier<List<DocumentSnapshot>> {
  late final Query<Map<String, dynamic>> query;

  List<DocumentSnapshot> build(
    Query<Map<String, dynamic>> query,
  );
}

/// See also [_AppItemsPagination].
@ProviderFor(_AppItemsPagination)
const _appItemsPaginationProvider = _AppItemsPaginationFamily();

/// See also [_AppItemsPagination].
class _AppItemsPaginationFamily extends Family<List<DocumentSnapshot>> {
  /// See also [_AppItemsPagination].
  const _AppItemsPaginationFamily();

  /// See also [_AppItemsPagination].
  _AppItemsPaginationProvider call(
    Query<Map<String, dynamic>> query,
  ) {
    return _AppItemsPaginationProvider(
      query,
    );
  }

  @override
  _AppItemsPaginationProvider getProviderOverride(
    covariant _AppItemsPaginationProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'_appItemsPaginationProvider';
}

/// See also [_AppItemsPagination].
class _AppItemsPaginationProvider extends AutoDisposeNotifierProviderImpl<
    _AppItemsPagination, List<DocumentSnapshot>> {
  /// See also [_AppItemsPagination].
  _AppItemsPaginationProvider(
    Query<Map<String, dynamic>> query,
  ) : this._internal(
          () => _AppItemsPagination()..query = query,
          from: _appItemsPaginationProvider,
          name: r'_appItemsPaginationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$appItemsPaginationHash,
          dependencies: _AppItemsPaginationFamily._dependencies,
          allTransitiveDependencies:
              _AppItemsPaginationFamily._allTransitiveDependencies,
          query: query,
        );

  _AppItemsPaginationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final Query<Map<String, dynamic>> query;

  @override
  List<DocumentSnapshot> runNotifierBuild(
    covariant _AppItemsPagination notifier,
  ) {
    return notifier.build(
      query,
    );
  }

  @override
  Override overrideWith(_AppItemsPagination Function() create) {
    return ProviderOverride(
      origin: this,
      override: _AppItemsPaginationProvider._internal(
        () => create()..query = query,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<_AppItemsPagination,
      List<DocumentSnapshot>> createElement() {
    return _AppItemsPaginationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _AppItemsPaginationProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _AppItemsPaginationRef
    on AutoDisposeNotifierProviderRef<List<DocumentSnapshot>> {
  /// The parameter `query` of this provider.
  Query<Map<String, dynamic>> get query;
}

class _AppItemsPaginationProviderElement
    extends AutoDisposeNotifierProviderElement<_AppItemsPagination,
        List<DocumentSnapshot>> with _AppItemsPaginationRef {
  _AppItemsPaginationProviderElement(super.provider);

  @override
  Query<Map<String, dynamic>> get query =>
      (origin as _AppItemsPaginationProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
