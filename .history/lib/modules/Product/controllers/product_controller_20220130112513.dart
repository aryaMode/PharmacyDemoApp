import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductController {
  final String id;
  late Future<DatabaseReference> ref;
  ProductController({required this.id});
  Future<DatabaseReference> getDatabaseRef() async {
    GroupsController.ref.get().then(
          (groupsSnapshot) => groupsSnapshot.children.forEach(
            (groupSnapshot) {
              groupSnapshot.child("products").ref.orderByChild("id").equalTo(id).get().then((productsSnapshot) => productsSnapshot.children.first;
            },
          ),
        );
  }
}
