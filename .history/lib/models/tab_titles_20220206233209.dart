class TabTitles{
  static List<String> _locations = [];
  static List<String> get locations => _locations;

  static set locationFromMap(List<String> locations) {
    TabTitles._locations = locations;
  }
}