import 'package:firebase_database/firebase_database.dart';

Object getJson(String path) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref(path);
  DatabaseEvent event = await ref.once();
  return event.snapshot.value;
}
