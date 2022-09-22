class Locations {
  List<String> locations;
  Locations({
    required this.locations,
  });
  List<String> get 
  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      locations: List<String>.from(map['locations']),
    );
  }
}
