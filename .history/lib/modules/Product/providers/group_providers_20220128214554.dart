import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

DatabaseReference ref = database.ref("product tab/groups");
Query orderByIndexQuery = ref.orderByChild("index");

final groupsProvider = Provider<List<Group>>(
  (ref) {
    late List<Group> groups;
    Query query = orderByIndexQuery;
    Stream<DatabaseEvent> stream = query.onValue;
    stream.map(
      (DatabaseEvent event) {
        Map<String, dynamic> groupsData =
            event.snapshot.value as Map<String, dynamic>;
        List<Group> groups = [];
        groupsData.forEach((key, value) {
          groups.add(Group.fromMap(value));
        });
        return groups;
      },
    ).listen(
      (event) {
        groups = event;
      },
    );
    return groups;
  },
);

final selectedGroupsProvider = Provider.family<List<Group>, List<int>>(
  (ref, List<int> groupIndices) {
    var groups = ref.watch(groupsProvider);
    return groups
        .where((element) => groupIndices.contains(element.index))
        .toList();
  },
);

final productsProvider = Provider<List<Product>>((ref) => <Product>[]);

final productProvider = Provider.family<Product?, int>((ref, int productIndex) {
  return ref.watch(productsProvider).elementAt(productIndex);
});


// final groupsProvider = FutureProvider<List<Group>>(
//   (ref) async {
//     dynamic data = await getData(path: "product tab/groups");
//     List<Group> groups =
//         List<Group>.from((data)?.map((group) => Group.fromMap(group)));
//     return groups;
//   },
// );

// final groupProvider = StateProvider<Group>((ref) => throw UnimplementedError());



