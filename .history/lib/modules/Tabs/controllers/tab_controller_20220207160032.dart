import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
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
    futureRef = getGroupRef();
  }
  Future<DatabaseReference?> getGroupRef() async {
    DatabaseReference? ref;
    Query targetedTabQuery =
        TabsController(reader: reader).ref.orderByChild("index").equalTo(index);
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

  Future<void> addFolder(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("folders");
    await FirebaseDBHelper.addObjectByIndex(
        object: Folder.emptyFolder(index: index).toMap(),
        baseRef: ref,
        index: index);
  }

  Future<void> deleteFolder(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("folders");
    // Query? query = ref?.orderByChild("index").equalTo(index);
    // await query?.get().then(
    //   (foldersSnapshot) async {
    //     for (DataSnapshot folders in foldersSnapshot.children) {
    //       Map foldersMap = folders.value as Map;
    //       print(foldersMap["images"].length);
    //       for (int i = (foldersMap["images"] as Map).length - 1; i >= 0; i--) {
    //         await ProductController(id: productMap["id"]).deleteImage(i);
    //       }
    //     }
    //   },
    // );
    await FirebaseDBHelper.deleteByIndex(
      baseRef: ref,
      index: index,
    );
    // await ref?.get().then(
    //   (value) {
    //     if (value.children.isEmpty) {
    //       TabsController().delete(this.index);
    //     }
    //   },
    // );
  }

  Future<void> reorderFolder(int oldIndex, int newIndex) async {
    DatabaseReference? ref = (await futureRef)?.child("folders");
    await FirebaseDBHelper.reorder(
      baseRef: ref,
      oldIndex: oldIndex,
      newIndex: newIndex,
    );
  }
}
