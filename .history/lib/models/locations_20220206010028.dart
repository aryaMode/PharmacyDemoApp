class Locations {
  static List<String> _locations = [];
  static List<String> get location => locations;

  static set locationFromMap(List<String> locations) {
    Locations.locations = locations;
  }
}
