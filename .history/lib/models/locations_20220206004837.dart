class Locations {
  static List<String> locations = [];
  static List<String> get location => locations;

  set Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }
}
