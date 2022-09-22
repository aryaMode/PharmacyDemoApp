import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/repositories/group_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<List<Group>> {
  GroupController(List<Group> state) : super(state);
  var prevState;
  void retrieveGroups() {
    GroupRepository.retrieveGroups().listen(
      (groups) {
        prevState = state;
        state = groups;
      },on 
    );
  }

  void addGroup(String name) {}
}
