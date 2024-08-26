// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threads.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadsHash() => r'37231297da0d864fa0e98d626258fd75bfbb4780';

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
  late final AppItem parent;

  Stream<List<AppItem>> build(
    AppItem parent,
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
    AppItem parent,
  ) {
    return ThreadsProvider(
      parent,
    );
  }

  @visibleForOverriding
  @override
  ThreadsProvider getProviderOverride(
    covariant ThreadsProvider provider,
  ) {
    return call(
      provider.parent,
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
    AppItem parent,
  ) : this._internal(
          () => Threads()..parent = parent,
          from: threadsProvider,
          name: r'threadsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$threadsHash,
          dependencies: ThreadsFamily._dependencies,
          allTransitiveDependencies: ThreadsFamily._allTransitiveDependencies,
          parent: parent,
        );

  ThreadsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parent,
  }) : super.internal();

  final AppItem parent;

  @override
  Stream<List<AppItem>> runNotifierBuild(
    covariant Threads notifier,
  ) {
    return notifier.build(
      parent,
    );
  }

  @override
  Override overrideWith(Threads Function() create) {
    return ProviderOverride(
      origin: this,
      override: ThreadsProvider._internal(
        () => create()..parent = parent,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parent: parent,
      ),
    );
  }

  @override
  (AppItem,) get argument {
    return (parent,);
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
      () => create()..parent = parent,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      parent: parent,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadsProvider && other.parent == parent;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parent.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThreadsRef on AutoDisposeStreamNotifierProviderRef<List<AppItem>> {
  /// The parameter `parent` of this provider.
  AppItem get parent;
}

class _ThreadsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Threads, List<AppItem>>
    with ThreadsRef {
  _ThreadsProviderElement(super.provider);

  @override
  AppItem get parent => (origin as ThreadsProvider).parent;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
