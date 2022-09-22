import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

main()async  {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("product tab/groups");
    DatabaseEvent event = await ref.orderByChild("name");
}

// import 'dart:convert';
// main() {
//   var lists = json.decode('[[123],[122],[411]]');
//   print(lists);
//   for(var i = 0; i < lists.length; i++) {
//     print('L $i');
//   	for(var j in lists[i]) {
//       print(j);      
//     }
//   }
// }
