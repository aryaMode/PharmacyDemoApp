import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Locations {
  static List<String> _locations = [];
  static List<String> get locations => _locations;

  static set locations(List<String> locations) {
    Locations._locations = locations;
  }

  static Future<void> updateLocationsFromFirebase() async {
    
    DatabaseReference ref = FirebaseDBHelper.database.ref("locations");
    DataSnapshot locationsSnapshot = await ref.get();
    _locations = (locationsSnapshot.value as List)
        .map((location) => location.toString())
        .toList();
  }

  static Future<void> updateLocationsFromSharedPref() async {
    
    SharedPreferences prefs = await SharedPreferences.getInstance()
  }
}
