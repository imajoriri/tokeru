// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogp_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ogpControllerHash() => r'da6fbaee30bc48ef42ccf6ebc579bd88f81f8048';

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

abstract class _$OgpController extends BuildlessAsyncNotifier<Ogp> {
  late final String url;

  FutureOr<Ogp> build({
    required String url,
  });
}

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
///
/// Copied from [OgpController].
@ProviderFor(OgpController)
const ogpControllerProvider = OgpControllerFamily();

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
///
/// Copied from [OgpController].
class OgpControllerFamily extends Family<AsyncValue<Ogp>> {
  /// OGP情報を取得するコントローラー。
  ///
  /// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
  ///
  /// Copied from [OgpController].
  const OgpControllerFamily();

  /// OGP情報を取得するコントローラー。
  ///
  /// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
  ///
  /// Copied from [OgpController].
  OgpControllerProvider call({
    required String url,
  }) {
    return OgpControllerProvider(
      url: url,
    );
  }

  @override
  OgpControllerProvider getProviderOverride(
    covariant OgpControllerProvider provider,
  ) {
    return call(
      url: provider.url,
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
  String? get name => r'ogpControllerProvider';
}

/// OGP情報を取得するコントローラー。
///
/// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
///
/// Copied from [OgpController].
class OgpControllerProvider
    extends AsyncNotifierProviderImpl<OgpController, Ogp> {
  /// OGP情報を取得するコントローラー。
  ///
  /// 表示のたびにAPIを叩くのは非効率なので、keepAliveをtrueにしている。
  ///
  /// Copied from [OgpController].
  OgpControllerProvider({
    required String url,
  }) : this._internal(
          () => OgpController()..url = url,
          from: ogpControllerProvider,
          name: r'ogpControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ogpControllerHash,
          dependencies: OgpControllerFamily._dependencies,
          allTransitiveDependencies:
              OgpControllerFamily._allTransitiveDependencies,
          url: url,
        );

  OgpControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  FutureOr<Ogp> runNotifierBuild(
    covariant OgpController notifier,
  ) {
    return notifier.build(
      url: url,
    );
  }

  @override
  Override overrideWith(OgpController Function() create) {
    return ProviderOverride(
      origin: this,
      override: OgpControllerProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<OgpController, Ogp> createElement() {
    return _OgpControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OgpControllerProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OgpControllerRef on AsyncNotifierProviderRef<Ogp> {
  /// The parameter `url` of this provider.
  String get url;
}

class _OgpControllerProviderElement
    extends AsyncNotifierProviderElement<OgpController, Ogp>
    with OgpControllerRef {
  _OgpControllerProviderElement(super.provider);

  @override
  String get url => (origin as OgpControllerProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
