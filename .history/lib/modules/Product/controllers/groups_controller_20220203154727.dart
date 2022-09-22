import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class GroupsController {
  static DatabaseReference ref =
      FirebaseDBHelper.database.ref("product tab/groups");
  Future<void> add({required int index, String? name}) async {
    await FirebaseDBHelper.addObjectByIndex(
        object: Group.emptyGroup(index: index, name: name).toMap(),
        baseRef: ref,
        index: index);
  }

  Future<void> delete(int index) async {
    await FirebaseDBHelper.deleteByIndex(baseRef: ref, index: index);

    if()
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await FirebaseDBHelper.reorder(
        baseRef: ref, oldIndex: oldIndex, newIndex: newIndex);
  }
}
