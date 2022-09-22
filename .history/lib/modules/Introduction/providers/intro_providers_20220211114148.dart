import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Introduction/controlller/intro_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final introImagesProvider = StreamProvider<List<Img>>((ref) {
  Query query = IntroImagesController.ref.orderByChild("index");
  Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        SplayTreeMap<String, dynamic> images =
            objectConversion(event.snapshot.value);
        List<Group> groups = [];
        groupsData.forEach(
          (key, value) {
            groups.add(Group.fromMap(value));
          },
        );
        return groups;
      },
    );
});
