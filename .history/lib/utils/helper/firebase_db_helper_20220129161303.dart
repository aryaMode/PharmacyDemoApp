import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> add({required Object? object, DatabaseReference baseRef, int index}) async {
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
