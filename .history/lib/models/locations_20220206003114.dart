import 'package:flutter/foundation.dart';

class Locations {
  

  void getLocationfromMap(Map<String, dynamic> map) {
    locations = List<String>.from(map['locations']);
  }

}
class Locations {
  List<String> locations;
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}