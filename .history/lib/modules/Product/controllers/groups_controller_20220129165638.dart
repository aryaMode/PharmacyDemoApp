import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class GroupsController {
DatabaseReference ref = FirebaseDbHelperdatabase.ref("product tab/groups");
  Future<void> add(int index) async {
    await FirebaseDbHelper.addObjectByIndex(
        object: Group.emptyGroup(index).toMap(), baseRef: ref, index: index);
  }

  Future<void> delete(int index) async {
    await FirebaseDbHelper.deleteByIndex(baseRef: ref, index: index);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await FirebaseDbHelper.reorder(
        baseRef: ref, oldIndex: oldIndex, newIndex: newIndex);
  }
}
