import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:demo_catalog_app/modules/Tabs/models/tab.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tabsStreamProvider = StreamProvider.autoDispose<List<Tab>>(
  (ref) {
    Query query = TabsController(reader: ref.read).ref.orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> tabsData =
            event.snapshot.value as Map<String, dynamic>;
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

final selectedTabIndicesProvider = StateProvider.autoDispose<int>((ref) => -1);

final folders = StateProvider.autoDisposeList<<Folder>(
  (ref) {
    final index = ref.watch(pageIndexProvider);
    return ref.watch(productsProvider).elementAt(index);
  },
);
