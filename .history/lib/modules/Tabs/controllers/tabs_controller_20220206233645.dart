import 'package:demo_catalog_app/models/tab_titles.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:demo_catalog_app/modules/Tabs/models/tab.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';

class TabsController {
  final Reader reader;
  DatabaseReference ref;
  TabsController({
    required this.reader,
  }) : ref = FirebaseDBHelper.database.ref(
            "tabs/${TabTitles.tabTitles[(reader(currentTabIndexProvider))]}");

  Future<void> add({required int index, String? name}) async {
    await FirebaseDBHelper.addObjectByIndex(
      object: Tab.emptyTab(index: index, name: name).toMap(),
      baseRef: ref,
      index: index,
    );
  }

  Future<void> delete({required int index}) async {
    await FirebaseDBHelper.deleteByIndex(
      baseRef: ref,
      index: index,
    );

    await ref.get().then(
      (value) {
        if (value.children.isEmpty) {
          add(index: 0);
        }
      },
    );
  }

  Future<void> reorder({required int oldIndex, required int newIndex}) async {
    await FirebaseDBHelper.reorder(
        baseRef: ref, oldIndex: oldIndex, newIndex: newIndex);
  }
}
