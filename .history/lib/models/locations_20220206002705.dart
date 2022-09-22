import 'package:flutter/foundation.dart';

class Locations {
  static List<String> locations;

  Map<String, dynamic> toMap() {
    return {
      'locations': locations,
    };
  }

  void getLocationfromMap(Map<String, dynamic> map) {
    locations = List<String>.from(map['locations']);
  }

}
