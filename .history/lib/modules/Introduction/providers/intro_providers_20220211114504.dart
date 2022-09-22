import 'dart:collection';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Introduction/controlller/intro_controller.dart';
import 'package:demo_catalog_app/utils/helper/conversion.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final introImagesProvider = StreamProvider<List<Img>?>((ref) {
  Query query = IntroImagesController.ref.orderByChild("index");
  Stream<DatabaseEvent> stream = query.onValue;
    return stream.map(
      (DatabaseEvent event) {
        Map<>
        SplayTreeMap<String, dynamic> images =
            SplayTreeMap<String, Img>.from(
              map['images']
                  .map((key, value) => MapEntry(key, Img.fromMap(value))),
              (String a, String b) {
                return map['images'][a]['index'] - map['images'][b]['index'];
              },
            );
        return groups;
      },
    );
});
