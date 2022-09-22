import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  static final Locations _singleton = Locations._internal();

  factory Locations() {
    return _singleton;
  }

  Locations._internal();
}