import 'package:demo_catalog_app/modules/Product/models/group.dart';

final tabsStreamProvider = StreamProvider.autoDispose<List<Group>>(
  (ref) {
    Query query = GroupsController.ref.orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> groupsData =
            event.snapshot.value as Map<String, dynamic>;
        List<Group> groups = [];
        groupsData.forEach(
          (key, value) {
            groups.add(Group.fromMap(value));
          },
        );
        return groups;
      },
    );
  },
);