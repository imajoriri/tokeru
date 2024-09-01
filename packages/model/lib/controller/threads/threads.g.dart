// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threads.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadsHash() => r'733dbae688806e9b03161e54745febaf3efa7264';

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

abstract class _$Threads
    extends BuildlessAutoDisposeStreamNotifier<List<AppItem>> {
  late final String parentId;

  Stream<List<AppItem>> build(
    String parentId,
  );
}

/// See also [Threads].
@ProviderFor(Threads)
const threadsProvider = ThreadsFamily();

/// See also [Threads].
class ThreadsFamily extends Family {
  /// See also [Threads].
  const ThreadsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'threadsProvider';

  /// See also [Threads].
  ThreadsProvider call(
    String parentId,
  ) {
    return ThreadsProvider(
      parentId,
    );
  }

  @visibleForOverriding
  @override
  ThreadsProvider getProviderOverride(
    covariant ThreadsProvider provider,
  ) {
    return call(
      provider.parentId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(Threads Function() create) {
    return _$ThreadsFamilyOverride(this, create);
  }
}

class _$ThreadsFamilyOverride implements FamilyOverride {
  _$ThreadsFamilyOverride(this.overriddenFamily, this.create);

  final Threads Function() create;

  @override
  final ThreadsFamily overriddenFamily;

  @override
  ThreadsProvider getProviderOverride(
    covariant ThreadsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [Threads].
class ThreadsProvider
    extends AutoDisposeStreamNotifierProviderImpl<Threads, List<AppItem>> {
  /// See also [Threads].
  ThreadsProvider(
    String parentId,
  ) : this._internal(
          () => Threads()..parentId = parentId,
          from: threadsProvider,
          name: r'threadsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$threadsHash,
          dependencies: ThreadsFamily._dependencies,
          allTransitiveDependencies: ThreadsFamily._allTransitiveDependencies,
          parentId: parentId,
        );

  ThreadsProvider._internal(
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
  Stream<List<AppItem>> runNotifierBuild(
    covariant Threads notifier,
  ) {
    return notifier.build(
      parentId,
    );
  }

  @override
  Override overrideWith(Threads Function() create) {
    return ProviderOverride(
      origin: this,
      override: ThreadsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<Threads, List<AppItem>>
      createElement() {
    return _ThreadsProviderElement(this);
  }

  ThreadsProvider _copyWith(
    Threads Function() create,
  ) {
    return ThreadsProvider._internal(
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
    return other is ThreadsProvider && other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThreadsRef on AutoDisposeStreamNotifierProviderRef<List<AppItem>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _ThreadsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Threads, List<AppItem>>
    with ThreadsRef {
  _ThreadsProviderElement(super.provider);

  @override
  String get parentId => (origin as ThreadsProvider).parentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
