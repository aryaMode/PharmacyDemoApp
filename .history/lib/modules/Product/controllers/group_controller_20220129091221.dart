import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

class GroupController {
  final int index;
  GroupController({required this.index});

  Future<void> delete() async {
    Query targetedGroupQuery = orderByIndexQuery.equalTo(index);
     Query groupsQuery = orderByIndexQuery.startAfter(index);
    await groupsQuery.get().then(
          (groupsSnapshot) => 
           groupsSnapshot.children.forEach(
            (group) async {
              await group.ref
                  .child("index")
                  .set(ServerValue.increment(1))
                  ;
            },
          ),
        );
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
  
  void addProduct(int index){
    
  }
}
