// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiChatHash() => r'8b84f4028221ab62beec82ba4b00b6806f3795a4';

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

abstract class _$AiChat extends BuildlessAutoDisposeNotifier<ChatSession> {
  late final AppItem appItem;

  ChatSession build(
    AppItem appItem,
  );
}

/// See also [AiChat].
@ProviderFor(AiChat)
const aiChatProvider = AiChatFamily();

/// See also [AiChat].
class AiChatFamily extends Family {
  /// See also [AiChat].
  const AiChatFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiChatProvider';

  /// See also [AiChat].
  AiChatProvider call(
    AppItem appItem,
  ) {
    return AiChatProvider(
      appItem,
    );
  }

  @visibleForOverriding
  @override
  AiChatProvider getProviderOverride(
    covariant AiChatProvider provider,
  ) {
    return call(
      provider.appItem,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(AiChat Function() create) {
    return _$AiChatFamilyOverride(this, create);
  }
}

class _$AiChatFamilyOverride implements FamilyOverride {
  _$AiChatFamilyOverride(this.overriddenFamily, this.create);

  final AiChat Function() create;

  @override
  final AiChatFamily overriddenFamily;

  @override
  AiChatProvider getProviderOverride(
    covariant AiChatProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// See also [AiChat].
class AiChatProvider
    extends AutoDisposeNotifierProviderImpl<AiChat, ChatSession> {
  /// See also [AiChat].
  AiChatProvider(
    AppItem appItem,
  ) : this._internal(
          () => AiChat()..appItem = appItem,
          from: aiChatProvider,
          name: r'aiChatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$aiChatHash,
          dependencies: AiChatFamily._dependencies,
          allTransitiveDependencies: AiChatFamily._allTransitiveDependencies,
          appItem: appItem,
        );

  AiChatProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.appItem,
  }) : super.internal();

  final AppItem appItem;

  @override
  ChatSession runNotifierBuild(
    covariant AiChat notifier,
  ) {
    return notifier.build(
      appItem,
    );
  }

  @override
  Override overrideWith(AiChat Function() create) {
    return ProviderOverride(
      origin: this,
      override: AiChatProvider._internal(
        () => create()..appItem = appItem,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        appItem: appItem,
      ),
    );
  }

  @override
  (AppItem,) get argument {
    return (appItem,);
  }

  @override
  AutoDisposeNotifierProviderElement<AiChat, ChatSession> createElement() {
    return _AiChatProviderElement(this);
  }

  AiChatProvider _copyWith(
    AiChat Function() create,
  ) {
    return AiChatProvider._internal(
      () => create()..appItem = appItem,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      appItem: appItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AiChatProvider && other.appItem == appItem;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, appItem.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AiChatRef on AutoDisposeNotifierProviderRef<ChatSession> {
  /// The parameter `appItem` of this provider.
  AppItem get appItem;
}

class _AiChatProviderElement
    extends AutoDisposeNotifierProviderElement<AiChat, ChatSession>
    with AiChatRef {
  _AiChatProviderElement(super.provider);

  @override
  AppItem get appItem => (origin as AiChatProvider).appItem;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
