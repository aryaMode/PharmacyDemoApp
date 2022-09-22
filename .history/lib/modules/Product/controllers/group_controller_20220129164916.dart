import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class GroupController {
  final int index;
  DatabaseReference ref;
  GroupController({required this.index}){
    Query targetedGroupQuery = Groups.equalTo(index);
    targetedGroupQuery.get().then(
      (groupsSnapshot) {
        groupsSnapshot.children.forEach(
          (group) {
            ref = group.ref;
          },
        );
      },
    );
  };

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
