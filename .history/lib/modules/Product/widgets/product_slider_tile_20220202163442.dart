import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/modules/Product/providers/product_providers.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/image_picker.dart';
import 'package:demo_catalog_app/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/scrollable_images.dart';
import '../../../widgets/text_widget.dart';

class ProductsliderTile extends ConsumerWidget {
  final int productIndex;

  ProductsliderTile({
    required this.productIndex,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProduct = ref.watch(productProvider(productIndex));
    return asyncProduct.when(data: (product)=>,error:(e,st)=>Text("Error : $e") ,loading:()=>CircularProgressIndicator());
    
  }
}
