import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class TabsController {
  final String tabName;
  DatabaseReference ref;
  TabsController(this.tabName)
      : ref = FirebaseDBHelper.database.ref("tabs/$tabName");

  Future<void> add({required int index, String? name}) async {
    await FirebaseDBHelper.addObjectByIndex(
        object: Tab.emptyTab(index: index, name: name).toMap(),
        baseRef: ref,
        index: index);
  }

  Future<void> delete(int index) async {
    await FirebaseDBHelper.deleteByIndex(
      baseRef: ref,
      index: index,
    );

    await ref.get().then(
      (value) {
        if (value.children.isEmpty) {
          GroupsController().add(index: 0);
        }
      },
    );
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await FirebaseDBHelper.reorder(
        baseRef: ref, oldIndex: oldIndex, newIndex: newIndex);
  }

}
