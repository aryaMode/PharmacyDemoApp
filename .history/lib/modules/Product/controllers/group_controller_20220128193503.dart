import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<List<Group>> {
  GroupController(List<Group> state) : super(state);
  var prevState;
  void retrieveGroups() {
    GroupsController.retrieve().listen(
      (groups) {
        prevState = state;
        state = groups;
      },
      onError: (e) {
        if (prevState != null) {
          state = prevState;
          prevState = null;
        }
      },
    );
  }
}
