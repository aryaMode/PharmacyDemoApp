import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupsStreamProvider = StreamProvider<List<Group>>(
  (ref) {
    print("inside groups provider");
    Query query = GroupsController.ref.orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> groupsData =
            event.snapshot.value as Map<String, dynamic>;
        List<Group> groups = [];
        groupsData.forEach(
          (key, value) {
            groups.add(Group.fromMap(value));
          },
        );
        return groups;
      },
    );
  },
);

final groupsProvider = StateProvider<List<Group>>(
  (ref) => <Group>[],
);

final selectedGroupsIndicesProvider =
    StateProvider<List<int>>((ref) => <int>[]);

final productsProvider = StateProvider<List<Product>>(
  (ref) {
    final groups = ref.watch(groupsProvider);
    final selectedGroupIndices = ref.watch(selectedGroupsIndicesProvider);
    return groups
        .where((element) => selectedGroupIndices.length!=0selectedGroupIndices.contains(element.index))
        .map((e) => e.products.values)
        .expand((element) => element)
        .toList();
  },
);

// StreamProvider<List<Product>>(
//   (ref) {
//     var groups = ref.watch(groupsStreamProvider.stream);
//     print("inside products provider");
//     List<int> groupIndices = ref.watch(selectedGroupsIndicesProvider);
//     return groups.map(
//       (event) => event
//           .where((element) => groupIndices.length != 0
//               ? groupIndices.contains(element.index)
//               : true)
//           .map((group) => group.products.values)
//           .expand((products) => products)
//           .toList(),
//     );
//   },
// );

final productProvider = StateProvider.family<Product, int>((ref, index) {
  return ref.watch(productsProvider).elementAt(index);
});

// StreamProvider.family<Product, int>(
//   (ref, int productIndex) {
//     print("inside product provider");
//     return ref
//         .watch(productsProvider.stream)
//         .map((event) => event.elementAt(productIndex));
//   },
// );


// final groupsProvider = FutureProvider<List<Group>>(
//   (ref) async {
//     dynamic data = await getData(path: "product tab/groups");
//     List<Group> groups =
//         List<Group>.from((data)?.map((group) => Group.fromMap(group)));
//     return groups;
//   },
// );

// final groupProvider = StateProvider<Group>((ref) => throw UnimplementedError());
