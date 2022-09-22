class Locations {
  static List<String> locations;
  Locations({
    required this.locations,
  });
  static List<String> get location => locations;

  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }
}
