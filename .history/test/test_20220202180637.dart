import 'dart:collection';
import 'dart:ffi';

// import 'package:firebase_database/firebase_database.dart';

// firebase() async {
//   final FirebaseDatabase database = FirebaseDatabase.instance;
//   DatabaseReference ref = database.ref("product tab/groups");
//   Query query = ref.orderByChild("name");
//   var snapshot = await query.get();
//   print(snapshot.value);
// }

void main() {
  List<TestClass> lund = [TestClass() , Test1()];
  print(lund.forEach((element) {element.i}));
}

class TestClass {
  int i = 0;
}

class Test1 extends TestClass {
  void testFunc() {
    super.i = 10;
  }
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
