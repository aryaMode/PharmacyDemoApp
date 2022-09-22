import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class GroupRepository {
  static Stream<List<Group>> retrieveGroups() {
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
    );
  }

  static void addEmptyGroup(int index) {
    DatabaseReference ref = database.ref("product tab/groups");
    
  }
}
