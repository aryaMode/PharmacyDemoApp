import 'dart:typed_data';

import 'package:flutter/services.dart';

Future<Uint8List> assetToBytes(String path) async {
  var memoryImage = await rootBundle.load(path);
  Uint8List output = memoryImage.buffer.asUint8List();
  return output;
}
