import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Object? getJson(String path) async {
  DatabaseReference ref = database.ref(path);
  DatabaseEvent event = await ref.once();
  return event.snapshot.value;
}

void setJson({requiredString path,required Map<String, Object?> json}) async {
  DatabaseReference ref = database.ref(path);
  await ref.set(json);
}

void updateJson({required String path,required Map<String, Object?> json}) async {
  DatabaseReference ref = database.ref(path);
  await ref.update(json);
}

void deleteJson(String path) async {
  DatabaseReference ref = database.ref(path);
  await ref.remove();
}

queryJson(String path,)
