import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductController {
  final String id;
  late Future<DatabaseReference> ref;
  ProductController({required this.id});
  Future<DatabaseReference> getDatabaseRef() async {
    late DatabaseReference 
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
                      product.ref;
                    },
                  );
                },
              );
            },
          ),
        );
  }
}
