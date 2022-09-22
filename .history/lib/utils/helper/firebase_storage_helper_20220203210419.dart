import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:universal_html/html.dart' as html;
import 'package:uuid/uuid.dart';

import 'image_helper.dart';

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future<Map<String, String>> uploadWebImage(html.File _imageFile) async {
  String _imageName = _imageFile.name.toString();

  firebase_storage.Reference storageRef =
      storage.ref('images/${Uuid().v1() + "." + _imageName.split(".").last}');

  firebase_storage.TaskSnapshot uploadTaskSnapshot =
      await storageRef.putData(await webImageToBytes(_imageFile));

  return {
    "url":
    await uploadTaskSnapshot.ref.getDownloadURL(),
    "":uploadTaskSnapshot.ref.name,
  };
}

Future<void> removeWebImage(String url) async {
  firebase_storage.Reference storageRef = storage.refFromURL(url);
  await storageRef.delete();
}
