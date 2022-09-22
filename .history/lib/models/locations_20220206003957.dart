import 'dart:convert';

import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  factory Locations({
    List<String> locations,
  }){
    locations = 
  }
  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }
}
