import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupsProvider = FutureProvider<List<Group>>((ref) async {
  dynamic data = await getData(path: "product tab/groups");
  Future<List<Group> groups =
      List<Group>.from((data)?.map((group) => Group.fromMap(group)));
  return groups;
});

final groupProvider = StateProvider<Group>((ref) => throw UnimplementedError());

final productProvider =
    StateProvider.family<Product, int>((ref, int productIndex) {
  return ref.watch(groupProvider).products[productIndex];
});
