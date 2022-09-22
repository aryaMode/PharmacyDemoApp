import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Introduction/models/intro_images.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class IntroImagesController {
  static DatabaseReference ref = FirebaseDBHelper.database.ref("introduction images");
  Future<void> addImage({required int index, String? name}) async {
    await FirebaseDBHelper.addObjectByIndex(
      object: Img.indexedImg(index: index).toMap(),
      baseRef: ref,
      index: index,
    );
  }

  Future<void> deleteImage(int index) async {
    Query? query = ref.orderByChild("index").equalTo(index);
    await query?.get().then(
      (imagesSnapshot) async {
        for (DataSnapshot image in imagesSnapshot.children) {
          String? prevURL = (image.value as Map)["url"];
          await removeWebImage(prevURL);
        }
      },
    );
    await FirebaseDBHelper.deleteByIndex(
      baseRef: ref,
      index: index,
    );

    await ref?.get().then(
      (value) {
        if (value.children.isEmpty) {
          addImage(0);
        }
      },
    );
  }

}
