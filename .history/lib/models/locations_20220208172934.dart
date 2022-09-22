import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class Locations {
  static List<String> _locations = [];
  static List<String> get locations => _locations;

  static set locations(List<String> locations) {
    Locations._locations = locations;
  }

  static updateLocationsFromFirebase() {
    DatabaseReference ref = FirebaseDBHelper.database.ref("locations");
    ref.
  }
}
