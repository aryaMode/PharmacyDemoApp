import 'package:flutter/foundation.dart';

class Locations {
  static List<String> locations;

  Map<String, dynamic> toMap() {
    return {
      'locations': locations,
    };
  }

  void getLocationfromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }

  @override
  String toString() => 'Locations(locations: $locations)';

}
