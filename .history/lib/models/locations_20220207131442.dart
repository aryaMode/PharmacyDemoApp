class Locations {
  static List<String> _locations = [];
  static List<String> get locations => _locations;

  static set locationFromMap(List<String> locations) {
    Locations._locations = locations;
  }
}
lund()
Locations.locationFromMap();