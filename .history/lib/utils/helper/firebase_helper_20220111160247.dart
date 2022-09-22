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

Object? queryJson({
  required String path,
  String? orderByChild,
  Object? startAt,
  Object? endAt,
  int? limitToFirst,
  int? limitToLast,
}) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);

  Query query = ref.orderByChild();
  query = query.startAt(startAt);
  query = query.startAt(startAt);
  query = query.startAt(startAt);
  query = query.startAt(startAt);
  /* (orderByChild).startAt(startAt)
      .endAt(endAt) .limitToFirst(limitToFirst).limitToLast(limitToLast);
  return (await query.get()).value*/
  ;
}
