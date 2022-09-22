import 'package:demo_catalog_app/modules/Introduction/models/intro_images.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class IntroImagesController {
  static DatabaseReference ref = FirebaseDBHelper.database.ref("introduction images/image");
  Future<void> addImage({required int index, String? name}) async {

    await FirebaseDBHelper.addObjectByIndex(
        object: IntroImages.emptyIntroImages().toMap(),
        baseRef: ref,
        index: index);
  }
}
