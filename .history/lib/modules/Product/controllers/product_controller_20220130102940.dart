import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductController {
  final String id;
  late Future<DatabaseReference> ref;
  ProductController({required this.id});
  Future<DatabaseReference> getDatabaseRef() async {
    GroupsController.ref
  }
}
