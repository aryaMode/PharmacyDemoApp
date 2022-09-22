import 'package:firebase_database/firebase_database.dart';


class GroupController {
  final int index;
  GroupController({required this.index});

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");
  void delete() {
    Query targetedGroupQuery = orderByIndexQuery.equalTo(index);
    targetedGroupQuery.get().then((groupsSnapshot) {
      groupsSnapshot.children.forEach(
        (group) {
          group.ref.remove();
        },
      );
    });
  }

  void rename(String newName) {
    Query targetedGroupQuery = orderByIndexQuery.equalTo(index);
    targetedGroupQuery.get().then((groupsSnapshot) {
      groupsSnapshot.children.forEach(
        (group) {
          group.ref.update({"name": newName});
        },
      );
    });
  }
  
}
