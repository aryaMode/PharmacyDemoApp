import 'dart:convert';

import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  factory Locations({
    required List<String> locations,
  }) {
    this.locations = locations;
  }

  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }
}

class SingletonOne {
  List<String> locations;

  SingletonOne._privateConstructor();

  static final SingletonOne _instance = SingletonOne._privateConstructor();

  factory SingletonOne() {
    return _instance;
  }

}
