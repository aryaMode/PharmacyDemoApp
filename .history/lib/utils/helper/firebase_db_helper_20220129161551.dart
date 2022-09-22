import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class FirebaseDbHelper {
  static Future<void> addObjectByIndex(
      {required Object? object,
      required DatabaseReference baseRef,
      required int index}) async {
    Query groupsQuery = baseRef.orderByChild("index").startAt(index);
    await groupsQuery.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (group) async {
              await group.ref.child("index").set(ServerValue.increment(1));
            },
          ),
        );
    baseRef.update({Uuid().v4(): object});
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
}
