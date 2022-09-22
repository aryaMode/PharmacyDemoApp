import 'package:demo_catalog_app/modules/Product/controllers/product_controller.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:demo_catalog_app/utils/helper/firebase_storage_helper.dart';
import 'package:firebase_database/firebase_database.dart';

import 'groups_controller.dart';

class GroupController {
  final int index;
  Future<DatabaseReference?>? futureRef;
  GroupController({required this.index}) {
    futureRef = getGroupRef();
  }
  Future<DatabaseReference?> getGroupRef() async {
    DatabaseReference? ref;
    Query targetedGroupQuery =
        GroupsController.ref.orderByChild("index").equalTo(index);
    await targetedGroupQuery.get().then(
      (groupsSnapshot) {
        groupsSnapshot.children.forEach(
          (group) {
            ref = group.ref;
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

  Future<void> addProduct(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("products");
    await FirebaseDBHelper.addObjectByIndex(
        object: Product.emptyProduct(index: index).toMap(),
        baseRef: ref,
        index: index);
  }

  Future<void> deleteProduct(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("products");
    Query? query = ref?.orderByChild("index").equalTo(index);
    query?.get().then(
      (productsSnapshot) async {
        for (DataSnapshot product in productsSnapshot.children) {
          Map productMap = product.value as Map;
          for (int i = 0; i < productMap["images"].length; i++)
            ProductController(id: (product.value as Map)["id"]).deleteImage(i);
          await removeWebImage(productMap["logo"]?["url"]);
          await removeWebImage(productMap["other"]?["url"]);
          await removeWebImage(productMap["offer"]?["url"]);
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
          GroupsController().delete(this.index);
        }
      },
    );
  }

  Future<void> reorderProduct(int oldIndex, int newIndex) async {
    DatabaseReference? ref = (await futureRef)?.child("products");
    await FirebaseDBHelper.reorder(
      baseRef: ref,
      oldIndex: oldIndex,
      newIndex: newIndex,
    );
  }
}
