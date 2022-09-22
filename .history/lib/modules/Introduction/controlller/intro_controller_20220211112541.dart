import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class IntroImagesController {
  static DatabaseReference ref = FirebaseDBHelper.database.ref("introduction images");
  Future<void> add({required int index, String? name}) async {
    await FirebaseDBHelper.addObjectByIndex(
        object: Intro.emptyGroup(index: index, name: name).toMap(),
        baseRef: ref,
        index: index);
  }
}
