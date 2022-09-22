import 'dart:convert';
import 'dart:typed_data';
import 'package:universal_html/html.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/services.dart';

Future<Uint8List> assetToBytes(String path) async {
  var memoryImage = await rootBundle.load(path);
  Uint8List output = memoryImage.buffer.asUint8List();
  return output;
}

Future<File?> pickImage() async {
  return await ImagePickerWeb.getImageAsFile();
}

Uint8List loadImage(_imageFile) {
  final reader = FileReader();
  reader.readAsDataUrl(_imageFile);
  var bytes;
  reader.onLoadEnd.listen((event) {
    bytes =
        const Base64Decoder().convert(reader.result.toString().split(",").last);
  });
  return bytes;
}

// void _uploadingImage() async {
//   fb
//       .storage()
//       .refFromURL('gs://flutter-web-66179.appspot.com/')
//       .child('images/$_imageName')
//       .put(_imageFile)
//       .future
//       .then((_) {});

//   fb.StorageReference storageRef = fb.storage().ref('images/$_imageName');

//   fb.UploadTaskSnapshot uploadTaskSnapshot =
//       await storageRef.put(_imageFile).future;

//   Uri url = await uploadTaskSnapshot.ref.getDownloadURL();

//   setState(() {
//     _url = '$url';
//     _uploading = false;
//   });

//   _uploadImage();
// }

// _uploadImage() async {
//   DocumentReference docReferenceProductDetails =
//       Firestore.instance.collection('products').document();
//   docReferenceProductDetails.setData({'image': _url});
// }
