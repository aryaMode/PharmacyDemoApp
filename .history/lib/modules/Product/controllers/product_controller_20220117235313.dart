import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductController extends StateNotifier{
  ProductController(state) : super(Product.emptyProduct());

}