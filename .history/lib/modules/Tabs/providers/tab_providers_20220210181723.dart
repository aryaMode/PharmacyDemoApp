import 'dart:convert';

import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:demo_catalog_app/modules/Tabs/models/tab.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabsStreamProvider = StreamProvider.autoDispose<List<Tab>>(
  (ref) {
    Query query = TabsController(reader: ref.watch).ref.orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> tabsData =
            jsonDecode(jsonEncode(event.snapshot.value));
        List<Tab> tabs = [];
        tabsData.forEach(
          (key, value) {
            tabs.add(Tab.fromMap(value));
          },
        );
        return tabs;
      },
    );
  },
);

final tabsProvider = StateProvider.autoDispose<List<Tab>>(
  (ref) => <Tab>[],
);

final tabIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

final foldersProvider = StateProvider.autoDispose<List<Folder>?>(
  (ref) {
    final index = ref.watch(tabIndexProvider);
    final tabs = ref.watch(tabsProvider);
    final locationIndex = ref.watch(locationIndexProvider);
    if (tabs.length == 0) return null;
    return tabs
        .elementAt(index)
        .locationFolders
        .values
        .firstWhere((locationFolders) =>
            locationFolders.location == Locations.locations[locationIndex])
        .folders
        ?.values
        .toList();
  },
);

final folderProvider =
    StateProvider.family.autoDispose<Folder?, int>((ref, index) {
  return ref.watch(foldersProvider)?.elementAt(index);
});
