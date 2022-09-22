import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

import 'groups_controller.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

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
    await Future.delayed(Duration(seconds: 1));
    await targetedGroupQuery.get().then(
      (groupsSnapshot) {
        groupsSnapshot.children.forEach(
          (group) {
            ref = group.ref;
            print("first");
            print(ref?.path);
          },
        );
      },
    );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference? ref = await futureRef;
    print("second");
    print(ref?.path);
    await ref?.update({"name": newName});
  }

  Future<void> addProduct(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("products");
    await FirebaseDbHelper.addObjectByIndex(
        object: Product.emptyProduct(index: index).toMap(),
        baseRef: ref,
        index: index);
  }

  Future<void> deleteProduct(int index) async {
    DatabaseReference? ref = (await futureRef)?.child("products");
    await FirebaseDbHelper.deleteByIndex(baseRef: ref, index: index);
  }

  Future<void> reorderProduct(int oldIndex, int newIndex) async {
    DatabaseReference? ref = (await futureRef)?.child("products");
    await FirebaseDbHelper.reorder(
        baseRef: ref, oldIndex: oldIndex, newIndex: newIndex);
  }
}
