import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class TabTitles{
  static List<String> _tabTitles = [];
  static List<String> get tabTitles => _tabTitles;

  static set tabTitles(List<String> locations) {
    TabTitles._tabTitles = locations;
  }

  static updateTabTitlesFromFirebase() async {
    DatabaseReference ref = FirebaseDBHelper.database.ref("locations");
    DataSnapshot tabTitlesSnapshot = await ref.get();
    tabTitles = (tabTitlesSnapshot.value as List)
        .map((tabTitle) => location.toString())
        .toList();
  }
}