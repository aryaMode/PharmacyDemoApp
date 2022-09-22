import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
Future? getData({
  String? path,
}) async {
  DatabaseReference ref = database.ref(path);
  DatabaseEvent event = await ref.once();
  return event.snapshot.value;
}

Future<void> setData({
  String? path,
  required Object? json,
}) async {
  DatabaseReference ref = database.ref(path);
  await ref.set(json);
}

Future<void> updateValue({
  String? path,
  required Map<String, Object?> json,
}) async {
  DatabaseReference ref = database.ref(path);
  await ref.update(json);
}

Future<void> deleteData({
  String? path,
}) async {
  DatabaseReference ref = database.ref(path);
  await ref.remove();
}

Future<Object?> queryJson({
  String? path,
  String? orderByChild,
  Object? startAt,
  Object? endAt,
  int? limitToFirst,
  int? limitToLast,
}) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  Query query = ref;
  query = orderByChild != null ? ref.orderByChild(orderByChild) : query;
  query = query.startAt(startAt);
  query = query.endAt(endAt);
  query = limitToFirst != null ? ref.limitToFirst(limitToFirst) : query;
  query = limitToLast != null ? ref.limitToLast(limitToLast) : query;
  return (await query.get()).value;
}

Future<void> add(Query baseQuery,int index) async {
    Query groupsQuery = baseQuery.startAt(index);
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
    ref.update({Uuid().v4(): Group.emptyGroup(index).toMap()});
  }