import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.g.dart';

@riverpod
AppAnalytics appAnalytics(AppAnalyticsRef ref) => AppAnalytics(
      analytics: FirebaseAnalytics.instance,
    );

class AppAnalytics {
  const AppAnalytics({required this.analytics});
  final FirebaseAnalytics analytics;

  Future<void> logEvent(String name, Map<String, Object> parameters) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }
}
