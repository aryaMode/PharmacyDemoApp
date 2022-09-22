import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

class GroupsController {
  static Future<void> add(int index) async {
    FirebaseDbHelper.addObjectByIndex(
        object: object, baseRef: baseRef, index: index);
    Query groupsQuery = orderByIndexQuery.startAt(index);
    await groupsQuery.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (group) async {
              await group.ref.child("index").set(ServerValue.increment(1));
            },
          ),
        );
    ref.update({Uuid().v4(): Group.emptyGroup(index).toMap()});
  }

  Future<void> delete(int index) async {
    Query targetedGroupQuery = orderByIndexQuery.equalTo(index);
    targetedGroupQuery.get().then((groupsSnapshot) {
      groupsSnapshot.children.forEach(
        (group) {
          group.ref.remove();
        },
      );
    });
    Query groupsQuery = orderByIndexQuery.startAfter(index);
    await groupsQuery.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (group) async {
              await group.ref.child("index").set(ServerValue.increment(-1));
            },
          ),
        );
  }

  static void reorder(int oldIndex, int newIndex) {
    Query groupsQuery = orderByIndexQuery
        .startAt(oldIndex < newIndex ? oldIndex : newIndex)
        .limitToFirst((oldIndex - newIndex).abs() + 1);
    groupsQuery.get().then(
      (groupsSnapshot) {
        groupsSnapshot.children.forEach(
          (group) {
            if ((group.value as Map)["index"] == oldIndex) {
              group.ref.update({"index": newIndex});
            } else {
              group.ref
                  .child("index")
                  .set(ServerValue.increment((oldIndex - newIndex).sign));
            }
          },
        );
      },
    );
  }
}
