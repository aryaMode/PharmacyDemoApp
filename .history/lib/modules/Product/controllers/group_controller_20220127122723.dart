import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<List<Group>> {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  GroupController(List<Group> state) : super(state);
  void retrieveGroups() {
    Query query = database.ref("product tab/groups").orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> groupsData =
            event.snapshot.value as Map<String, dynamic>;
        List<Group> groups = [];
        groupsData.forEach((key, value) {
          groups.add(Group.fromMap(value));
        });
        return groups;
      },
    ).listen(
      (groups) {
        state = groups;
      },
    );
  }

  void 
}
