import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class TabsController {
  final String tabName;
  DatabaseReference ref;
  TabsController(this.tabName)
      : ref = FirebaseDBHelper.database.ref("tabs/$tabName");

  Future<void> add({required int index, String? name}) async {
    await FirebaseDBHelper.addObjectByIndex(
        object: Group.emptyGroup(index: index, name: name).toMap(),
        baseRef: ref,
        index: index);
  }
}
