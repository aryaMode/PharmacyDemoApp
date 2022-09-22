import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Object? getJson({
  required String path,
}) async {
  DatabaseReference ref = database.ref(path);
  DatabaseEvent event = await ref.once();
  return event.snapshot.value;
}

void setJson({
  required String path,
  required Map<String, Object?> json,
}) async {
  DatabaseReference ref = database.ref(path);
  await ref.set(json);
}

void updateJson({
  required String path,
  required Map<String, Object?> json,
}) async {
  DatabaseReference ref = database.ref(path);
  await ref.update(json);
}

void deleteJson({
  required String path,
}) async {
  DatabaseReference ref = database.ref(path);
  await ref.remove();
}

queryJson({
  required String path,
  String? orderBy,
  Object? 
}) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

Query query = ref.orderByChild("age").startAt(18).endAt(30).limi;

}
