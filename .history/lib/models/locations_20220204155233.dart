import 'dart:convert';

import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  Locations({
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Locations && listEquals(other.locations, locations);
  }

  @override
  int get hashCode => locations.hashCode;
}
