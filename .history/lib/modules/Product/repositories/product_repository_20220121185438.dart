import 'package:demo_catalog_app/modules/Product/models/product.dart';

@immutabl
class ProductRepository {
  final String groupName;
  const ProductRepository({this.groupName});
  Future<List<Product>> retrieveProducts() async {}
}
