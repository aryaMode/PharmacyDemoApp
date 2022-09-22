import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<List<Group>>{
  GroupController(List<Group> state) : super(state);
  List<Group> retrieveGroups(){
    Query query = database.ref("product tab/groups").orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> groupsData =
            event.snapshot.value as Map<String, dynamic>;
        List<Group> groups = [];
        groupsData.forEach((key, value) {
          groups.add(Group.fromMap(value));
        });
        return groups;
      },
    ).listen((groups) { });
  }
}