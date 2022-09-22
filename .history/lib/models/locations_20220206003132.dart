import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  static final Locations _singleton = Locations._internal();

  factory SinglLocationseton() {
    return _singleton;
  }

  Singleton._internal();
}