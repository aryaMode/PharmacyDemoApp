import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

class GroupsController {

  static void addEmpty(int index) {
    ref.update({Uuid().v4(): Group.emptyGroup(index).toMap()});
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
