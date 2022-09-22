import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/services.dart';

Future<Uint8List> assetImageToBytes(String path) async {
  var memoryImage = await rootBundle.load(path);
  Uint8List output = memoryImage.buffer.asUint8List();
  return output;
}

Future pickWebImage() async {
  return await ImagePickerWeb.getImageAsFile();
}

Uint8List webImageToBytes(_imageFile) {
  final reader = html.FileReader();
  reader.readAsDataUrl(_imageFile);
  var bytes;
  print(ima)
  reader.onLoadEnd.listen((event) {
    bytes =
        const Base64Decoder().convert(reader.result.toString().split(",").last);
  });
  return bytes;
}
