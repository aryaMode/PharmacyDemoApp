import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductController {
  final String id;
  Future<DatabaseReference?>? futureRef;
  ProductController({required this.id}){
    futureRef = getDatabaseRef();
  };
  Future<DatabaseReference?> getDatabaseRef() async {
    DatabaseReference? ref;
    await GroupsController.ref.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (groupSnapshot) async {
              await groupSnapshot.ref
                  .child("products")
                  .orderByChild("id")
                  .equalTo(id)
                  .get()
                  .then(
                (productsSnapshot) {
                  productsSnapshot.children.forEach(
                    (product) {
                      ref = product.ref;
                    },
                  );
                },
              );
            },
          ),
        );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"name": newName});
  }
}
