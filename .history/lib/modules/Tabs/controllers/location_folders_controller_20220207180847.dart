import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tab_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationFoldersController {
  final int index;
  final Reader reader;
  Future<DatabaseReference?>? futureRef;
  LocationFoldersController({
    required this.reader,
    required this.index,
  }) {
    futureRef = getLocationFoldersRef();
  }
  Future<DatabaseReference?> getLocationFoldersRef() async {
    DatabaseReference? ref;
    Query? targetedFoldersQuery =
        (await TabController(reader: reader, index: index).futureRef)
            ?.orderByChild("location")
            .equalTo(
              Locations.locations[reader(locationIndexProvider)],
            );
    final foldersSnapshot = await targetedFoldersQuery?.get();
    foldersSnapshot.children.forEach((element) { }), (previousValue, element) => null)
    for (DataSnapshot folder in foldersSnapshot?.children) {
      ref = folder.ref;
    }
    return ref;
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
