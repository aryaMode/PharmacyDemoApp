import 'dart:io';
import 'dart:typed_data';

import 'package:demo_catalog_app/models/img.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future<Img> uploadWebImage(PlatformFile _imageFile) async {
  firebase_storage.Reference storageRef =
      storage.ref('images/${Uuid().v1() + "." + (_imageFile.extension ?? "")}');

  firebase_storage.TaskSnapshot uploadTaskSnapshot =
      await storageRef.putData(_imageFile.bytes!);

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

Future<void> listExample() async {
  firebase_storage.ListResult result =
      await firebase_storage.FirebaseStorage.instance.ref("images").listAll();

  for (firebase_storage.Reference ref in [result.items.first]) {
    Uint8List? dataBytes = await ref.getData();
    Directory? appDocDir = await getDownloadsDirectory();
    File file;
    if (appDocDir != null) {
      print(appDocDir.path);
      final File file = File(appDocDir.path + '/my_file.txt');
      await file.writeAsString("text");
      // file = File(appDocDir.path + "/" + ref.name);
      // if (dataBytes != null) await file.writeAsBytes(dataBytes);
      // print(file.path);
      // await ref.writeToFile(file);
    }
  }
}
