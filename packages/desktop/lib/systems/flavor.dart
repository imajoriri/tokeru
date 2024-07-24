// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

enum Flavor {
  dev,
  dev2,
  prod,
}

extension FlavorEx on Flavor {
  static Flavor fromName(String name) {
    final flavor = Flavor.values.firstWhereOrNull((f) => f.name == name);
    if (flavor == null) {
      throw UnimplementedError();
    }
    return flavor;
  }
}
