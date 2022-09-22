import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/models/tab.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabsStreamProvider = StreamProvider.autoDispose<List<Tab>>(
  (ref) {
    Query query = TabsController.ref.orderByChild("index");
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