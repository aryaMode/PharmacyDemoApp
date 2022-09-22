import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

@immutable
class ProductRepository {
  final String groupName;

  const ProductRepository({required this.groupName});
  // Future<List<Product>> retrieveProducts() async {
  //   DatabaseReference ref = database.ref("product tab/groups");
  //   DatabaseEvent event = await ref.;
  //   List<Product> products;
  }
}
