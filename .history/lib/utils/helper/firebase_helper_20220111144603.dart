import 'package:firebase_database/firebase_database.dart';

getJson(String path) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref();
    DatabaseEvent event = await ref.once();
}