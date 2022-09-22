import 'dart:io';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductController {
  final String id;
  Future<DatabaseReference?>? futureRef;
  ProductController({required this.id}) {
    futureRef = getProductRef();
  }
  Future<DatabaseReference?> getProductRef() async {
    DatabaseReference? ref;
    await GroupsController.ref.get().then(
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

  Future<void> setLogo(PlatformFile logoFile) async {
    Img logo = await uploadWebImage(logoFile);
    DatabaseReference? ref = await futureRef;
    String? url =
        (await ref?.child("logo").child("url").get())?.value as String?;
    await removeWebImage(url);
    await ref?.update({"logo": logo.toMap()});
  }

  Future<void> setPriceListImage(
      PlatformFile priceListFile, Reader reader) async {
    Img priceListImage = await uploadWebImage(priceListFile);
    DatabaseReference? ref = await futureRef;
    DataSnapshot? locationSnapshots = await ref
        ?.child("priceList")
        .orderByChild("location")
        .equalTo(Locations.locations[reader(locationIndexProvider)])
        .get();
    DataSnapshot? locationSnapshot = locationSnapshots?.children.first;
    String? url = locationSnapshot?.child("url").value as String?;
    print(url);
    await removeWebImage(url);
    await locationSnapshot?.ref.update({"url": priceListImage});
  }

  Future<void> setOffer(PlatformFile offerFile) async {
    Img offer = await uploadWebImage(offerFile);
    DatabaseReference? ref = await futureRef;
    String? url =
        (await ref?.child("offer").child("url").get())?.value as String?;
    await removeWebImage(url);
    await ref?.update({"offer": offer.toMap()});
  }

  Future<void> setOther(PlatformFile otherFile) async {
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
