import 'dart:typed_data';
import 'package:universal_html/prefer_universal/html.dart' as html;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/services.dart';

Future<Uint8List> assetToBytes(String path) async {
  var memoryImage = await rootBundle.load(path);
  Uint8List output = memoryImage.buffer.asUint8List();
  return output;
}
// html.File _imageFile;
//   String _imageName;
//   Uint8List _byte;
//   bool _hasImage = false;
//   bool _uploading = false;
//   String _url = '';

void _pickImage() async {
  html.File imageFile =
      await ImagePickerWeb.getImage(outputType: ImageType.file);

  if (imageFile != null) {
    setState(() {
      _imageFile = imageFile;
      _imageName = imageFile.name.toString();
    });

    loadImage(_imageFile);
  }
}

loadImage(_imageFile) {
  final reader = FileReader();
  reader.readAsDataUrl(_imageFile);

  reader.onLoadEnd.listen((event) {
    var _bytesDataA =
        const Base64Decoder().convert(reader.result.toString().split(",").last);
    setState(() {
      _byte = _bytesDataA;
      _hasImage = true;
    });
  });
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
