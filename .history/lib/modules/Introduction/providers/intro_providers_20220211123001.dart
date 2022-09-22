import 'dart:collection';
import 'dart:convert';

import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Introduction/controlller/intro_controller.dart';
import 'package:demo_catalog_app/utils/helper/conversion.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final introImagesProvider = StreamProvider<SplayTreeMap<String, Img>?>((ref) {
  Query query = IntroImagesController.ref.orderByChild("index");
  Stream<DatabaseEvent> stream = query.onValue;
  return stream.map(
    (DatabaseEvent event) {
      Map<String, dynamic>? dataMap =
          jsonDecode(jsonEncode(event.snapshot.value));
      SplayTreeMap<String, Img>? images = 
      dataMap
      SplayTreeMap<String, Img>.from(
        dataMap.map(
          (key, value) => MapEntry(
            key,
            Img.fromMap(value),
          ),
        ),
        (String a, String b) {
          return dataMap[a]['index'] - dataMap[b]['index'];
        },
      );
      return images;
    },
  );
});
