import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
StreamProvider streamProvider = StreamProvider((ref) {
  return firebase();
});

Stream firebase() {
  // DatabaseReference ref = database.ref("product tab/groups");
  Query query = database.ref("product tab/groups").orderByChild("index");
  Stream<DatabaseEvent> stream = query.onValue;
  return stream.map((event) => Group.fromMap(event.snapshot.value as Map<>));
}
