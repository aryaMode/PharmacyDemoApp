import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref("product tab/groups");

class GroupRepository {
  static Stream<List<Group>> retrieveGroups() {
    Query query = ref.orderByChild("index");
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
    ref.update({Uuid().v4(): Group.emptyGroup(index).toMap()});
  }

  static Future<void> renameGroup(int index, String newName) async {
    var snapshot = await ref.equalTo(index, key: "index").ref;
    snapshot.set(newName);
  }
}
