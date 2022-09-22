import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Object? getJson(String path) async {
  DatabaseReference ref = database.ref(path);
  DatabaseEvent event = await ref.once();
  return event.snapshot.value;
}

Object? setJson(String path,Map json) async {
  DatabaseReference ref = database.ref(path);
  await 
}
