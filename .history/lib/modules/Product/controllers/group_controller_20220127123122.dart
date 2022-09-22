import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<List<Group>> {

  GroupController(List<Group> state) : super(state);
  void retrieveGroups() {
    .listen(
      (groups) {
        state = groups;
      },
    );
  }

  void addGroup(String name) {

  }
}
