import 'dart:io';

import 'package:demo_catalog_app/models/img.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

import 'image_helper.dart';

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future<Img> uploadWebImage(File _imageFile) async {
  String _extension = _imageFile.path.split(".").last;
  firebase_storage.Reference storageRef =
      storage.ref('images/${Uuid().v1() + "." + _extension}');

  firebase_storage.TaskSnapshot uploadTaskSnapshot =
      await storageRef.putData(await _imageFile.re);

  return Img(
    url: await uploadTaskSnapshot.ref.getDownloadURL(),
    name: uploadTaskSnapshot.ref.name,
  );
}

Future<void> removeWebImage(String? url) async {
  if (url != null) {
    firebase_storage.Reference storageRef = storage.refFromURL(url);
    await storageRef.delete();
  }
}
