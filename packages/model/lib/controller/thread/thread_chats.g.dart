// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_chats.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadChatsHash() => r'9f36c61caf508a2a927b4f9b8d3ae6f3fc6ab6ed';

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

abstract class _$ThreadChats
    extends BuildlessAutoDisposeStreamNotifier<List<AppItem>> {
  late final String parentId;

  Stream<List<AppItem>> build(
    String parentId,
  );
}

/// スレッドのチャットのリストを扱うコントローラー。
///
/// Copied from [ThreadChats].
@ProviderFor(ThreadChats)
const threadChatsProvider = ThreadChatsFamily();

/// スレッドのチャットのリストを扱うコントローラー。
///
/// Copied from [ThreadChats].
class ThreadChatsFamily extends Family {
  /// スレッドのチャットのリストを扱うコントローラー。
  ///
  /// Copied from [ThreadChats].
  const ThreadChatsFamily();

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'threadChatsProvider';

  /// スレッドのチャットのリストを扱うコントローラー。
  ///
  /// Copied from [ThreadChats].
  ThreadChatsProvider call(
    String parentId,
  ) {
    return ThreadChatsProvider(
      parentId,
    );
  }

  @visibleForOverriding
  @override
  ThreadChatsProvider getProviderOverride(
    covariant ThreadChatsProvider provider,
  ) {
    return call(
      provider.parentId,
    );
  }

  /// Enables overriding the behavior of this provider, no matter the parameters.
  Override overrideWith(ThreadChats Function() create) {
    return _$ThreadChatsFamilyOverride(this, create);
  }
}

class _$ThreadChatsFamilyOverride implements FamilyOverride {
  _$ThreadChatsFamilyOverride(this.overriddenFamily, this.create);

  final ThreadChats Function() create;

  @override
  final ThreadChatsFamily overriddenFamily;

  @override
  ThreadChatsProvider getProviderOverride(
    covariant ThreadChatsProvider provider,
  ) {
    return provider._copyWith(create);
  }
}

/// スレッドのチャットのリストを扱うコントローラー。
///
/// Copied from [ThreadChats].
class ThreadChatsProvider
    extends AutoDisposeStreamNotifierProviderImpl<ThreadChats, List<AppItem>> {
  /// スレッドのチャットのリストを扱うコントローラー。
  ///
  /// Copied from [ThreadChats].
  ThreadChatsProvider(
    String parentId,
  ) : this._internal(
          () => ThreadChats()..parentId = parentId,
          from: threadChatsProvider,
          name: r'threadChatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$threadChatsHash,
          dependencies: ThreadChatsFamily._dependencies,
          allTransitiveDependencies:
              ThreadChatsFamily._allTransitiveDependencies,
          parentId: parentId,
        );

  ThreadChatsProvider._internal(
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
    covariant ThreadChats notifier,
  ) {
    return notifier.build(
      parentId,
    );
  }

  @override
  Override overrideWith(ThreadChats Function() create) {
    return ProviderOverride(
      origin: this,
      override: ThreadChatsProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<ThreadChats, List<AppItem>>
      createElement() {
    return _ThreadChatsProviderElement(this);
  }

  ThreadChatsProvider _copyWith(
    ThreadChats Function() create,
  ) {
    return ThreadChatsProvider._internal(
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
    return other is ThreadChatsProvider && other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThreadChatsRef on AutoDisposeStreamNotifierProviderRef<List<AppItem>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _ThreadChatsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ThreadChats, List<AppItem>>
    with ThreadChatsRef {
  _ThreadChatsProviderElement(super.provider);

  @override
  String get parentId => (origin as ThreadChatsProvider).parentId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
