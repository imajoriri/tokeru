// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threads.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$threadsHash() => r'b80970e24e061c93814e9233aceae69a0426e654';

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
    extends BuildlessAutoDisposeStreamNotifier<List<AppChatItem>> {
  late final String chatId;

  Stream<List<AppChatItem>> build({
    required String chatId,
  });
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
  ThreadsProvider call({
    required String chatId,
  }) {
    return ThreadsProvider(
      chatId: chatId,
    );
  }

  @visibleForOverriding
  @override
  ThreadsProvider getProviderOverride(
    covariant ThreadsProvider provider,
  ) {
    return call(
      chatId: provider.chatId,
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
    extends AutoDisposeStreamNotifierProviderImpl<Threads, List<AppChatItem>> {
  /// See also [Threads].
  ThreadsProvider({
    required String chatId,
  }) : this._internal(
          () => Threads()..chatId = chatId,
          from: threadsProvider,
          name: r'threadsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$threadsHash,
          dependencies: ThreadsFamily._dependencies,
          allTransitiveDependencies: ThreadsFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  ThreadsProvider._internal(
    super.create, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  Stream<List<AppChatItem>> runNotifierBuild(
    covariant Threads notifier,
  ) {
    return notifier.build(
      chatId: chatId,
    );
  }

  @override
  Override overrideWith(Threads Function() create) {
    return ProviderOverride(
      origin: this,
      override: ThreadsProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  ({
    String chatId,
  }) get argument {
    return (chatId: chatId,);
  }

  @override
  AutoDisposeStreamNotifierProviderElement<Threads, List<AppChatItem>>
      createElement() {
    return _ThreadsProviderElement(this);
  }

  ThreadsProvider _copyWith(
    Threads Function() create,
  ) {
    return ThreadsProvider._internal(
      () => create()..chatId = chatId,
      name: name,
      dependencies: dependencies,
      allTransitiveDependencies: allTransitiveDependencies,
      debugGetCreateSourceHash: debugGetCreateSourceHash,
      from: from,
      chatId: chatId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadsProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ThreadsRef on AutoDisposeStreamNotifierProviderRef<List<AppChatItem>> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _ThreadsProviderElement
    extends AutoDisposeStreamNotifierProviderElement<Threads, List<AppChatItem>>
    with ThreadsRef {
  _ThreadsProviderElement(super.provider);

  @override
  String get chatId => (origin as ThreadsProvider).chatId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
