import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

class GroupsController {
  static Future<void> add(int index) async {
    FirebaseDbHelper.addObjectByIndex(
        object: Group.emptyGroup(index).toMap(), baseRef: ref, index: index);
  }

  Future<void> delete(int index) async {
    FirebaseDbHelper.deleteByIndex(baseRef: ref, index: index);
  }

  static void reorder(int oldIndex, int newIndex) {
    FirebaseDbHelper.reorder(baseRef: baseRef, oldIndex: oldIndex, newIndex: newIndex)
  }
}
