// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_items.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appItemsHash() => r'cfe2cbed12b76c89d246cf7b5f63163f3f7e9ca9';

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
    r'9e47affd31aee2ea4ec515c0f7f512b2a4c87170';

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
class _AppItemsPaginationFamily extends Family {
  /// See also [_AppItemsPagination].
  const _AppItemsPaginationFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_appItemsPaginationProvider';

  /// See also [_AppItemsPagination].
  _AppItemsPaginationProvider call(
    Query<Map<String, dynamic>> query,
  ) {
    return _AppItemsPaginationProvider(
      query,
    );
  }

  @visibleForOverriding
  @override
  _AppItemsPaginationProvider getProviderOverride(
    covariant _AppItemsPaginationProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(_AppItemsPagination Function() create) {
    return _$AppItemsPaginationFamilyOverride(this, create);
  }
}

class _$AppItemsPaginationFamilyOverride implements FamilyOverride {
  _$AppItemsPaginationFamilyOverride(this.overriddenFamily, this.create);

  final _AppItemsPagination Function() create;

  @override
  final _AppItemsPaginationFamily overriddenFamily;

  @override
  _AppItemsPaginationProvider getProviderOverride(
    covariant _AppItemsPaginationProvider provider,
  ) {
    return provider._copyWith(create);
  }
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
    super.create, {
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
  (Query<Map<String, dynamic>>,) get argument {
    return (query,);
  }

  @override
  AutoDisposeNotifierProviderElement<_AppItemsPagination,
      List<DocumentSnapshot>> createElement() {
    return _AppItemsPaginationProviderElement(this);
  }

  _AppItemsPaginationProvider _copyWith(
    _AppItemsPagination Function() create,
  ) {
    return _AppItemsPaginationProvider._internal(
      () => create()..query = query,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      query: query,
    );
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
