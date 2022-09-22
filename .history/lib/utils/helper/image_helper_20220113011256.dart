import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/services.dart';

Future<Uint8List> assetImageToBytes(String path) async {
  var memoryImage = await rootBundle.load(path);
  Uint8List output = memoryImage.buffer.asUint8List();
  return output;
}

Future<html.File?> pickWebImage() async {
  try{
  html.File? pickedFile = await ImagePickerWeb.getImageAsFile();
  return pickedFile;
}

Future<Uint8List> webImageToBytes(html.File file) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(file);
  await reader.onLoad.first;
  return reader.result as Uint8List;
}
