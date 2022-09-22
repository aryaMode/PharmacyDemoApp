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

Future<html.File?> pickWebImage() async {
  return await ImagePickerWeb.getImageAsFile();
}

Uint8List webImageToBytes(html.File _imageFile) {
  final reader = html.FileReader();
  reader.readAsDataUrl(_imageFile);
  var bytes;
  bytes =
      const Base64Decoder().convert(reader.result.toString().split(",").last);
  return bytes;
}

Future<Uint8List> webImageToBytes(html.File file) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(file);
  await reader.onLoad.first;
  return reader.result as Uint8List;
}
