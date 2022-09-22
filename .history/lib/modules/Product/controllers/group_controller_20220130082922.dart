import 'package:firebase_database/firebase_database.dart';

import 'groups_controller.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class GroupController {
  final int index;
  late Future<DatabaseReference> ref;
  GroupController({required this.index}):ref = getDatabaseRef(){
    ref = getDatabaseRef();
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

  void rename(String newName) {
    ref.update({"name": newName});
  }

  void addProduct(int index) {}
}
