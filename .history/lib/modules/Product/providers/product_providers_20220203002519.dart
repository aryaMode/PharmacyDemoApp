import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:demo_catalog_app/modules/Product/models/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupsStreamProvider = StreamProvider.autoDispose<List<Group>>(
  (ref) {
    Query query = GroupsController.ref.orderByChild("index");
    Stream<DatabaseEvent> stream = query.onValue;
    stream..forEach((event) {
Map<String, dynamic> groupsData =
            event.snapshot.value as Map<String, dynamic>;
        List<Group> groups = [];
        groupsData.forEach(
          (key, value) {
            groups.add(Group.fromMap(value));
          },
        );
        return groups;
    });
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

final groupsProvider = StateProvider.autoDispose<List<Group>>(
  (ref) => <Group>[],
);

final selectedGroupsIndicesProvider =
    StateProvider.autoDispose<List<int>>((ref) => <int>[]);

final productsProvider = StateProvider.autoDispose<List<Product>>(
  (ref) {
    final groups = ref.watch(groupsProvider);
    final selectedGroupIndices = ref.watch(selectedGroupsIndicesProvider);
    groups.forEach((element) {
      print(element.toMap());
    });
    return groups
        .where((element) => selectedGroupIndices.length != 0
            ? selectedGroupIndices.contains(element.index)
            : true)
        .map((e) => e.products.values)
        .expand((element) => element)
        .toList();
  },
);

final productProvider = StateProvider.autoDispose<Product>((ref) {
  final index = ref.watch(pageIndexProvider);
  return ref.watch(productsProvider).elementAt(index);
});

final pageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
