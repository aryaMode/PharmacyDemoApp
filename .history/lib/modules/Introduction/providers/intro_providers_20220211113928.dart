import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Introduction/controlller/intro_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final introImagesProvider = StateProvider<List<Img>>((ref) {
  Query query = IntroImagesController.ref.orderByChild("index");
});
