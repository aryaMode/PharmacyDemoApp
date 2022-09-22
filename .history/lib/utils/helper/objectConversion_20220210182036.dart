import 'dart:convert';

Map<String, dynamic> objectConversion(Object? object) {
  jsonDecode(jsonEncode(object))
}
