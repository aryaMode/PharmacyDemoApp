import 'package:firebase_database/firebase_database.dart';

import 'groups_controller.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class GroupController {
  final int index;
  late Future<DatabaseReference> futureRef;
  GroupController({required this.index}) {
    futureRef = getDatabaseRef();
  }
  Future<DatabaseReference> getDatabaseRef() async {
    late DatabaseReference ref;
    Query targetedGroupQuery =
        GroupsController.ref.orderByChild("index").equalTo(index);
    await targetedGroupQuery.get().then(
      (groupsSnapshot) {
        groupsSnapshot.children.forEach(
          (group) {
            ref = group.ref;
          },
        );
      },
    );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference ref = await futureRef;
    ref.update({"name": newName});
  }

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
