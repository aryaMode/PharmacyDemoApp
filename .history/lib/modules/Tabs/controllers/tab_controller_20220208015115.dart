import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabController {
  final int index;
  final Reader reader;
  Future<DatabaseReference?>? futureRef;
  TabController({
    required this.reader,
    required this.index,
  }) {
    futureRef = getTabRef();
  }
  Future<DatabaseReference?> getTabRef() async {
    DatabaseReference ref;
    Query? targetedTabQuery = TabsController(reader: reader)
        .ref
        .orderByChild("index")
        .equalTo(index);
    await targetedTabQuery.get().then(
      (tabsSnapshot) async {
        for (DataSnapshot tab in tabsSnapshot.children) {
          ref = tab.ref;
        }
      },
    );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"name": newName});
  }
}
