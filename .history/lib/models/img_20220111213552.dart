import 'dart:convert';
import 'package:demo_catalog_app/widgets/image_widget.dart';

class Img {
  String? url;
  String? path;
  Img({
    this.url,
    this.path,
  });import 'dart:convert';
main() {
  var lists = json.decode('[[123],[122],[411]]');
  print(lists);
  for(var i = 0; i < lists.length; i++) {
    print('L $i');
  	for(var j in lists[i]) {
      print(j);      
    }
  }
}

  ImageWidget toWidget() {
    return ImageWidget(image: this);
  }
}
