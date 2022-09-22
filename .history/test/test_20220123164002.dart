import 'dart:collection';

/* import 'package:firebase_database/firebase_database.dart';

firebase() async {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("product tab/groups");
  Query query = ref.orderByChild("name");
  var snapshot = await query.get();
  print(snapshot.value);
} */

void main() {
  test();
}

void test() {
  Map<String, dynamic> map = {
    "hi": {"index": 1},
    "bye": {"index": 0},
  };
  var output =
      SplayTreeMap.from(map, (a, b) => map[a]["index"] - map[b]["index"]);
  print(output);
}
