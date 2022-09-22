import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureProvider<String> futureProvider = FutureProvider<String>((ref) {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("product tab/groups");
  Query query = ref.orderByChild("name");
  var snapshot = await query.get();
  print(snapshot.value.toString());
});
firebase() async {
  
}
