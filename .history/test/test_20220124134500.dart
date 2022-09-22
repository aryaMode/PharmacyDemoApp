import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

// firebase() async {
//   final FirebaseDatabase database = FirebaseDatabase.instance;
//   DatabaseReference ref = database.ref("product tab/groups");
//   Query query = ref.orderByChild("name");
//   var snapshot = await query.get();
//   print(snapshot.value);
// }

void main() {
  test();
}

void test() {
  Map<String, dynamic> map = {
    "ahi": {"index": 1},
    "bye": {"index": 0},
  };
  var output = SplayTreeMap.from(
    map,
    // (a, b) => map[a]["index"] - map[b]["index"],
  );
  print(output);
}

class Integer {
  int i;
  Integer({
    required this.i,
  });

  Integer copyWith({
    int? i,
  }) {
    return Integer(
      i: i ?? this.i,
    );
  }
}

class AddInteger extends Integer {
  int j;
  AddInteger(int i) : super();
}
