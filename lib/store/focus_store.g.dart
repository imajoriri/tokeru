// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$focusNodeHash() => r'e739ec70a0689a6a1463113457bb5becc10b7f16';

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

/// See also [focusNode].
@ProviderFor(focusNode)
const focusNodeProvider = FocusNodeFamily();

/// See also [focusNode].
class FocusNodeFamily extends Family<FocusNode> {
  /// See also [focusNode].
  const FocusNodeFamily();

  /// See also [focusNode].
  FocusNodeProvider call(
    FocusNodeType key,
  ) {
    return FocusNodeProvider(
      key,
    );
  }

  @override
  FocusNodeProvider getProviderOverride(
    covariant FocusNodeProvider provider,
  ) {
    return call(
      provider.key,
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
  String? get name => r'focusNodeProvider';
}

/// See also [focusNode].
class FocusNodeProvider extends AutoDisposeProvider<FocusNode> {
  /// See also [focusNode].
  FocusNodeProvider(
    FocusNodeType key,
  ) : this._internal(
          (ref) => focusNode(
            ref as FocusNodeRef,
            key,
          ),
          from: focusNodeProvider,
          name: r'focusNodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$focusNodeHash,
          dependencies: FocusNodeFamily._dependencies,
          allTransitiveDependencies: FocusNodeFamily._allTransitiveDependencies,
          key: key,
        );

  FocusNodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final FocusNodeType key;

  @override
  Override overrideWith(
    FocusNode Function(FocusNodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FocusNodeProvider._internal(
        (ref) => create(ref as FocusNodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FocusNode> createElement() {
    return _FocusNodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FocusNodeProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FocusNodeRef on AutoDisposeProviderRef<FocusNode> {
  /// The parameter `key` of this provider.
  FocusNodeType get key;
}

class _FocusNodeProviderElement extends AutoDisposeProviderElement<FocusNode>
    with FocusNodeRef {
  _FocusNodeProviderElement(super.provider);

  @override
  FocusNodeType get key => (origin as FocusNodeProvider).key;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
