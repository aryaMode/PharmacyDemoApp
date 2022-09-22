import 'package:flutter/foundation.dart';

class Locations {
  List<String> _locations;

  void getLocationfromMap(Map<String, dynamic> map) {
    locations = List<String>.from(map['locations']);
  }

}
