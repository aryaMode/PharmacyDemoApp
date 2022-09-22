import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/location_folders_controller.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FolderController {
  int tabIndex, folderIndex;
  Reader reader;
  Future<DatabaseReference?>? futureRef;
  FolderController({required this.tabIndex,required this.folderIndex,required this.reader}) {
    futureRef = getProductRef();
  }
  Future<DatabaseReference?> getProductRef() async {
    DatabaseReference? ref;
    await LocationFoldersController(reader: reader,tabIndex: tabIndex).futureRef).get().then(
      (groupsSnapshot) async {
        for (DataSnapshot groupSnapshot in groupsSnapshot.children) {
          Query groupQuery = groupSnapshot.ref
              .child("products")
              .orderByChild("id")
              .equalTo(id);
          await groupQuery.get().then(
            (productsSnapshot) {
              productsSnapshot.children.forEach(
                (product) {
                  ref = product.ref;
                },
              );
            },
          );
        }
      },
    );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"name": newName});
  }

  Future<void> setTagline(String tagline) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"tagline": tagline});
  }

  Future<void> setLogo(File logoFile) async {
    Img logo = await uploadWebImage(logoFile);
    DatabaseReference? ref = await futureRef;
    String? url =
        (await ref?.child("logo").child("url").get())?.value as String?;
    await removeWebImage(url);
    await ref?.update({"logo": logo.toMap()});
  }

  Future<void> setOffer(File offerFile) async {
    Img offer = await uploadWebImage(offerFile);
    DatabaseReference? ref = await futureRef;
    String? url =
        (await ref?.child("offer").child("url").get())?.value as String?;
    await removeWebImage(url);
    await ref?.update({"offer": offer.toMap()});
  }

  Future<void> setOther(File otherFile) async {
    Img other = await uploadWebImage(otherFile);
    DatabaseReference? ref = await futureRef;
    String? url =
        (await ref?.child("other").child("url").get())?.value as String?;
    await removeWebImage(url);
    await ref?.update({"other": other.toMap()});
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

    await ref?.get().then(
      (value) {
        if (value.children.isEmpty) {
          addImage(0);
        }
      },
    );
  }

  Future<void> editImage(int index, File newImageFile) async {
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
