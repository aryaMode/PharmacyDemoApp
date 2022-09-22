import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabController {
  final int index;
  final Reader reader;
  Future<DatabaseReference?>? futureRef;
  TabController(
    this.reader, {
    required this.index,
  }) {
    futureRef = getGroupRef();
  }
  Future<DatabaseReference?> getGroupRef() async {
    DatabaseReference? ref;
    Query targetedGroupQuery =
        TabsController().ref.orderByChild("index").equalTo(index);
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
    await query?.get().then(
      (productsSnapshot) async {
        for (DataSnapshot product in productsSnapshot.children) {
          Map productMap = product.value as Map;
          print(productMap["images"].length);
          for (int i = (productMap["images"] as Map).length - 1; i >= 0; i--) {
            await ProductController(id: productMap["id"]).deleteImage(i);
          }
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
