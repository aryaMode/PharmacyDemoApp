import 'package:flutter/foundation.dart';

class Locations {
  static List<String> locations;
  stLocations({
    required this.locations,
  });

  Map<String, dynamic> toMap() {
    return {
      'locations': locations,
    };
  }

  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }

  @override
  String toString() => 'Locations(locations: $locations)';

}
