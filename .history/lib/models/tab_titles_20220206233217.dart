class TabTitles{
  static List<String> _tabTitles = [];
  static List<String> get locations => _tabTitles;

  static set locationFromMap(List<String> locations) {
    TabTitles._tabTitles = locations;
  }
}