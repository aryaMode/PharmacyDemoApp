class TabTitles{
  static List<String> _tabTitles = [];
  static List<String> get tabTitles => _tabTitles;

  static set locationFromMap(List<String> locations) {
    TabTitles._tabTitles = locations;
  }
}