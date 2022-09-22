import 'dart:convert';

import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  Locations({
    required this.locations,
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

  SingletonOne._privateConstructor(List<String> locations): this.locations = locations;

  static final SingletonOne _instance = SingletonOne._privateConstructor(List<String> locations): this.locations = locations;

  factory SingletonOne() {
    return _instance;
  }

}
