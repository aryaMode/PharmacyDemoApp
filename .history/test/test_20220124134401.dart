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

  Map<String, dynamic> toMap() {
    return {
      'i': i,
    };
  }

  factory Integer.fromMap(Map<String, dynamic> map) {
    return Integer(
      i: map['i']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Integer.fromJson(String source) => Integer.fromMap(json.decode(source));

  @override
  String toString() => 'Integer(i: $i)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Integer &&
      other.i == i;
  }

  @override
  int get hashCode => i.hashCode;
}
