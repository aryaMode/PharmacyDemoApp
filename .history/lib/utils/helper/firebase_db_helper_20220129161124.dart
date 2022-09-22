import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> add(Database baseQuery,int index) async {
    Query groupsQuery = baseQuery.orderByChild("index").startAt(index);
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
    baseQuery.update({Uuid().v4(): Group.emptyGroup(index).toMap()});
  }