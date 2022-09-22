import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class FirebaseDbHelper {
  static Future<void> addObjectByIndex({
    required Object? object,
    required DatabaseReference baseRef,
    required int index,
  }) async {
    Query query = baseRef.orderByChild("index").startAt(index);
    await groupsQuery.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (group) async {
              await group.ref.child("index").set(ServerValue.increment(1));
            },
          ),
        );
    baseRef.update({Uuid().v4(): object});
  }

  static Future<void> deleteByIndex({
    required DatabaseReference baseRef,
    required int index,
  }) async {
    Query targetedGroupQuery = baseRef.orderByChild("index").equalTo(index);
    targetedGroupQuery.get().then((groupsSnapshot) {
      groupsSnapshot.children.forEach(
        (group) {
          group.ref.remove();
        },
      );
    });
    Query groupsQuery = baseRef.orderByChild("index").startAfter(index);
    await groupsQuery.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (group) async {
              await group.ref.child("index").set(ServerValue.increment(-1));
            },
          ),
        );
  }
}
