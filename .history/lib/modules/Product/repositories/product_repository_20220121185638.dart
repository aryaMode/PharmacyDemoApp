import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:flutter/foundation.dart';

@immutable
class ProductRepository {
  final String groupName;
  const ProductRepository({required this.groupName});
  Future<List<Product>> retrieveProducts() async {
    List<Product> products = await getData("product tab/groups") 
  }
}
