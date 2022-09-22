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
  AddInteger(
    this.i
    this.j,
  ) : super(i:i);

  AddInteger copyWith({
    int? j,
  }) {
    return AddInteger(
      j ?? this.j,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'j': j,
    };
  }

  factory AddInteger.fromMap(Map<String, dynamic> map) {
    return AddInteger(
      map['j']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddInteger.fromJson(String source) => AddInteger.fromMap(json.decode(source));

  @override
  String toString() => 'AddInteger(j: $j)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AddInteger &&
      other.j == j;
  }

  @override
  int get hashCode => j.hashCode;
}
