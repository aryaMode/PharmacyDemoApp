import 'dart:convert';

import 'package:flutter/foundation.dart';

class Locations {
  List<String> locations;
  static final Locations _singleton = Locations._internal(locations: locations);

  factory Locations({
    required this.locations,
  }) {
    return _singleton;
  }

  Locations._internal({
    required this.locations,
  });

  Locations copyWith({
    List<String>? locations,
  }) {
    return Locations(
      locations: locations ?? this.locations,
    );
  }

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

  String toJson() => json.encode(toMap());

  factory Locations.fromJson(String source) => Locations.fromMap(json.decode(source));

  @override
  String toString() => 'Locations(locations: $locations)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Locations &&
      listEquals(other.locations, locations);
  }

  @override
  int get hashCode => locations.hashCode;
}
