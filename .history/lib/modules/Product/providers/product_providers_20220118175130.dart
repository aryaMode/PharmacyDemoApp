import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupsProvider = FutureProvider<List<Group>>((ref) {
  dynamic data = getData(path: "product tab/groups");
  List<Group> groups =
      List<Group>.from((data)?.map((group) => Group.fromMap(group)));
  return groups;
});

final groupProvider = StateProvider.family<Group>((ref,int groupIndex) {
  return 
});

final productProvider = StateProvider<Product>((ref) {});
