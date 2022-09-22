import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupsStreamProvider = StreamProvider<List<Group>>((ref) {
  Query query = GroupsController.ref.orderByChild("index");
  Stream<DatabaseEvent> stream = query.onValue;
  return stream.map(
    (DatabaseEvent event) {
      Map<String, dynamic> groupsData =
          event.snapshot.value as Map<String, dynamic>;
      List<Group> groups = [];
      groupsData.forEach((key, value) {
        groups.add(Group.fromMap(value));
      },);
      return groups;
    },
  );
});

final groupsProvider = Provider<List<Group>>((ref) => throw UnimplementedError());

final selectedGroupsIndicesProvider = StateProvider<List<int>>((ref) => throw UnimplementedError());

final productsProvider = Provider<List<Product>>(
  (ref) {
    var groups = ref.watch(groupsProvider);
    List<int> groupIndices = ref.watch(selectedGroupsIndicesProvider);
    return groups
        .where((element) => groupIndices.contains(element.index))
        .map((group) => group.products.values)
        .expand((products) => products)
        .toList();
  },
);

final productProvider = Provider.family<Product?, int>(
  (ref, int productIndex) {
    return ref.watch(productsProvider).elementAt(productIndex);
  },
);


// final groupsProvider = FutureProvider<List<Group>>(
//   (ref) async {
//     dynamic data = await getData(path: "product tab/groups");
//     List<Group> groups =
//         List<Group>.from((data)?.map((group) => Group.fromMap(group)));
//     return groups;
//   },
// );

// final groupProvider = StateProvider<Group>((ref) => throw UnimplementedError());
