import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/services.dart';


Future<Uint8List> webImageToBytes(html.File file) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(file);
  await reader.onLoad.first;
  return reader.result as Uint8List;
}
