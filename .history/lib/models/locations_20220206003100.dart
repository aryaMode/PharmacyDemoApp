import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;

  void getLocationfromMap(Map<String, dynamic> map) {
    locations = List<String>.from(map['locations']);
  }

}
class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}