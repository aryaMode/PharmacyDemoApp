import 'package:demo_catalog_app/modules/Product/models/product.dart';


class ProductRepository {
  final String groupName;
  const ProductRepository({this.groupName});
  Future<List<Product>> retrieveProducts() async {}
}
