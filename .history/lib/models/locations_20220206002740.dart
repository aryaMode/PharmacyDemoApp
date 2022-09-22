import 'package:flutter/foundation.dart';

class Locations {
  static List<String> locations;


  void getLocationfromMap(Map<String, dynamic> map) {
    locations = List<String>.from(map['locations']);
  }

}
