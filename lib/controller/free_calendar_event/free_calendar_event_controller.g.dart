// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_calendar_event_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$freeCalendarEventControllerHash() =>
    r'f57087b18e09f17852b2d559cffa8bcd9e110edb';

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

/// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
///
/// [duration]ごとに自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
/// [events]が空の場合は、全日が空き時間となる。
///
/// Copied from [freeCalendarEventController].
@ProviderFor(freeCalendarEventController)
const freeCalendarEventControllerProvider = FreeCalendarEventControllerFamily();

/// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
///
/// [duration]ごとに自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
/// [events]が空の場合は、全日が空き時間となる。
///
/// Copied from [freeCalendarEventController].
class FreeCalendarEventControllerFamily extends Family<List<FreeEvent>> {
  /// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
  ///
  /// [duration]ごとに自身をinvalidateするため、
  /// watchする位置はなるべくWidgetの末端に置くことを推薦する。
  /// [events]が空の場合は、全日が空き時間となる。
  ///
  /// Copied from [freeCalendarEventController].
  const FreeCalendarEventControllerFamily();

  /// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
  ///
  /// [duration]ごとに自身をinvalidateするため、
  /// watchする位置はなるべくWidgetの末端に置くことを推薦する。
  /// [events]が空の場合は、全日が空き時間となる。
  ///
  /// Copied from [freeCalendarEventController].
  FreeCalendarEventControllerProvider call(
    List<TitleEvent> events,
    DateTime start,
    DateTime end,
    Duration duration,
  ) {
    return FreeCalendarEventControllerProvider(
      events,
      start,
      end,
      duration,
    );
  }

  @override
  FreeCalendarEventControllerProvider getProviderOverride(
    covariant FreeCalendarEventControllerProvider provider,
  ) {
    return call(
      provider.events,
      provider.start,
      provider.end,
      provider.duration,
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
  String? get name => r'freeCalendarEventControllerProvider';
}

/// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
///
/// [duration]ごとに自身をinvalidateするため、
/// watchする位置はなるべくWidgetの末端に置くことを推薦する。
/// [events]が空の場合は、全日が空き時間となる。
///
/// Copied from [freeCalendarEventController].
class FreeCalendarEventControllerProvider
    extends AutoDisposeProvider<List<FreeEvent>> {
  /// [TitleEvent]のリストから[FreeEvent]のリストを取得するコントローラー。
  ///
  /// [duration]ごとに自身をinvalidateするため、
  /// watchする位置はなるべくWidgetの末端に置くことを推薦する。
  /// [events]が空の場合は、全日が空き時間となる。
  ///
  /// Copied from [freeCalendarEventController].
  FreeCalendarEventControllerProvider(
    List<TitleEvent> events,
    DateTime start,
    DateTime end,
    Duration duration,
  ) : this._internal(
          (ref) => freeCalendarEventController(
            ref as FreeCalendarEventControllerRef,
            events,
            start,
            end,
            duration,
          ),
          from: freeCalendarEventControllerProvider,
          name: r'freeCalendarEventControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$freeCalendarEventControllerHash,
          dependencies: FreeCalendarEventControllerFamily._dependencies,
          allTransitiveDependencies:
              FreeCalendarEventControllerFamily._allTransitiveDependencies,
          events: events,
          start: start,
          end: end,
          duration: duration,
        );

  FreeCalendarEventControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.events,
    required this.start,
    required this.end,
    required this.duration,
  }) : super.internal();

  final List<TitleEvent> events;
  final DateTime start;
  final DateTime end;
  final Duration duration;

  @override
  Override overrideWith(
    List<FreeEvent> Function(FreeCalendarEventControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FreeCalendarEventControllerProvider._internal(
        (ref) => create(ref as FreeCalendarEventControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        events: events,
        start: start,
        end: end,
        duration: duration,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<FreeEvent>> createElement() {
    return _FreeCalendarEventControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FreeCalendarEventControllerProvider &&
        other.events == events &&
        other.start == start &&
        other.end == end &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, events.hashCode);
    hash = _SystemHash.combine(hash, start.hashCode);
    hash = _SystemHash.combine(hash, end.hashCode);
    hash = _SystemHash.combine(hash, duration.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FreeCalendarEventControllerRef
    on AutoDisposeProviderRef<List<FreeEvent>> {
  /// The parameter `events` of this provider.
  List<TitleEvent> get events;

  /// The parameter `start` of this provider.
  DateTime get start;

  /// The parameter `end` of this provider.
  DateTime get end;

  /// The parameter `duration` of this provider.
  Duration get duration;
}

class _FreeCalendarEventControllerProviderElement
    extends AutoDisposeProviderElement<List<FreeEvent>>
    with FreeCalendarEventControllerRef {
  _FreeCalendarEventControllerProviderElement(super.provider);

  @override
  List<TitleEvent> get events =>
      (origin as FreeCalendarEventControllerProvider).events;
  @override
  DateTime get start => (origin as FreeCalendarEventControllerProvider).start;
  @override
  DateTime get end => (origin as FreeCalendarEventControllerProvider).end;
  @override
  Duration get duration =>
      (origin as FreeCalendarEventControllerProvider).duration;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
