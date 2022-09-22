import 'package:firebase_database/firebase_database.dart';

import 'groups_controller.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class GroupController {
  final int index;
  late Future<DatabaseReference> ref;
  GroupController({required this.index}) {
    
  }
  void init(){

  }

  void rename(String newName) {
    ref.update({"name": newName});
  }

  void addProduct(int index) {}
}
