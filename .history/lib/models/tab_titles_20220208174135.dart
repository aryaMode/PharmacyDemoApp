class TabTitles{
  static List<String> _tabTitles = [];
  static List<String> get tabTitles => _tabTitles;

  static set tabTitles(List<String> locations) {
    TabTitles._tabTitles = locations;
  }

  static updateTabFromFirebase() async {
    DatabaseReference ref = FirebaseDBHelper.database.ref("locations");
    DataSnapshot locationsSnapshot = await ref.get();
    locations = (locationsSnapshot.value as List)
        .map((location) => location.toString())
        .toList();
  }
}