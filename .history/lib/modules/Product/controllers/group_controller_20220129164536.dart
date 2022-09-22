import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

class GroupController {
  final int index;
  DatabaseReference ref
  GroupController({required this.index});

  void rename(String newName) {
    Query targetedGroupQuery = orderByIndexQuery.equalTo(index);
    targetedGroupQuery.get().then(
      (groupsSnapshot) {
        groupsSnapshot.children.forEach(
          (group) {
            group.ref.update({"name": newName});
          },
        );
      },
    );
  }

  void addProduct(int index) {}
}
