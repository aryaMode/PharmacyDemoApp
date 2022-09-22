import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
FutureProvider<String> futureProvider = FutureProvider<String>((ref) async {
  return firebase();
});
Future<String> firebase() async {
  DatabaseReference ref = database.ref("product tab/groups");
  Query query = ref.orderByKey();
  var snapshot = await query.get();
  return snapshot.value.toString();
}
