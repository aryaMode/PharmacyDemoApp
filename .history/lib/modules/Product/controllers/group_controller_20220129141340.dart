import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

class GroupController {
  final int index;
  GroupController({required this.index});

  

  void addProduct(int index) {}
}
