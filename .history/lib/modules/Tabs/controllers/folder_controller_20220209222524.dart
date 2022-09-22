
import 'dart:io';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/location_folders_controller.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FolderController {
  int tabIndex, folderIndex;
  Reader reader;
  Future<DatabaseReference?>? futureRef;
  FolderController(
      {required this.tabIndex,
      required this.folderIndex,
      required this.reader}) {
    futureRef = getProductRef();
  }
  Future<DatabaseReference?> getProductRef() async {
    DatabaseReference? ref;
    Query? foldersQuery =
        (await LocationFoldersController(reader: reader, tabIndex: tabIndex)
                .futureRef)
            ?.child("folders")
            .orderByChild("index")
            .equalTo(folderIndex);
    await foldersQuery?.get().then(
      (foldersSnapshot) {
        foldersSnapshot.children.forEach(
          (folder) {
            ref = folder.ref;
          },
        );
      },
    );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"name": newName});
  }

  Future<void> setBackgroundImage(PlatformFile imageFile) async {
    Img backgroundImage = await uploadWebImage(imageFile);
    DatabaseReference? ref = await futureRef;
    String? url = (await ref?.child("backgroundImage").child("url").get())
        ?.value as String?;
    await removeWebImage(url);
    await ref?.update({"backgroundImage": backgroundImage.toMap()});
  }

  Future<void> addImage(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("images");
    await FirebaseDBHelper.addObjectByIndex(
      object: Img.indexedImg(index: index).toMap(),
      baseRef: ref,
      index: index,
    );
  }

  Future<void> deleteImage(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("images");
    Query? query = ref?.orderByChild("index").equalTo(index);
    await query?.get().then(
      (imagesSnapshot) async {
        for (DataSnapshot image in imagesSnapshot.children) {
          String? prevURL = (image.value as Map)["url"];
          await removeWebImage(prevURL);
        }
      },
    );
    await FirebaseDBHelper.deleteByIndex(
      baseRef: ref,
      index: index,
    );
  }

  Future<void> editImage(int index, PlatformFile newImageFile) async {
    Img newImage = await uploadWebImage(newImageFile);
    DatabaseReference? ref = (await futureRef)?.child("images");
    Query? query = ref?.orderByChild("index").equalTo(index);
    await query?.get().then(
      (imagesSnapshot) async {
        for (DataSnapshot image in imagesSnapshot.children) {
          String? prevURL = (image.value as Map)["url"];
          await removeWebImage(prevURL);
          image.ref.update(
            newImage.copyWith(index: index).toMap(),
          );
        }
      },
    );
  }
}
