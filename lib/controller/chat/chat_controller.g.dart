// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatControllerHash() => r'2ec9ab98f1ea4c61347ecf2f80e8b414dfb20fd5';

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

abstract class _$ChatController
    extends BuildlessAutoDisposeAsyncNotifier<List<Chat>> {
  late final String? todoId;

  FutureOr<List<Chat>> build(
    String? todoId,
  );
}

/// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
///
/// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
///
/// Copied from [ChatController].
@ProviderFor(ChatController)
const chatControllerProvider = ChatControllerFamily();

/// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
///
/// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
///
/// Copied from [ChatController].
class ChatControllerFamily extends Family<AsyncValue<List<Chat>>> {
  /// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
  ///
  /// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
  ///
  /// Copied from [ChatController].
  const ChatControllerFamily();

  /// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
  ///
  /// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
  ///
  /// Copied from [ChatController].
  ChatControllerProvider call(
    String? todoId,
  ) {
    return ChatControllerProvider(
      todoId,
    );
  }

  @override
  ChatControllerProvider getProviderOverride(
    covariant ChatControllerProvider provider,
  ) {
    return call(
      provider.todoId,
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
  String? get name => r'chatControllerProvider';
}

/// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
///
/// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
///
/// Copied from [ChatController].
class ChatControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChatController, List<Chat>> {
  /// [todoId]に紐づく[Chat]のリストを保持するコントローラー。
  ///
  /// 参照されなくなってもキャッシュを[cacheTime]だけ保持する。
  ///
  /// Copied from [ChatController].
  ChatControllerProvider(
    String? todoId,
  ) : this._internal(
          () => ChatController()..todoId = todoId,
          from: chatControllerProvider,
          name: r'chatControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatControllerHash,
          dependencies: ChatControllerFamily._dependencies,
          allTransitiveDependencies:
              ChatControllerFamily._allTransitiveDependencies,
          todoId: todoId,
        );

  ChatControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todoId,
  }) : super.internal();

  final String? todoId;

  @override
  FutureOr<List<Chat>> runNotifierBuild(
    covariant ChatController notifier,
  ) {
    return notifier.build(
      todoId,
    );
  }

  @override
  Override overrideWith(ChatController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChatControllerProvider._internal(
        () => create()..todoId = todoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todoId: todoId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChatController, List<Chat>>
      createElement() {
    return _ChatControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatControllerProvider && other.todoId == todoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatControllerRef on AutoDisposeAsyncNotifierProviderRef<List<Chat>> {
  /// The parameter `todoId` of this provider.
  String? get todoId;
}

class _ChatControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChatController, List<Chat>>
    with ChatControllerRef {
  _ChatControllerProviderElement(super.provider);

  @override
  String? get todoId => (origin as ChatControllerProvider).todoId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
