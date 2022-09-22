import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductController {
  final String id;
  Future<DatabaseReference?>? futureRef;
  ProductController({required this.id}) {
    // futureRef = getProductRef();
  }
  Future<DatabaseReference?> getProductRef() async {
    DatabaseReference? ref;
    await FirebaseDbHelper.database.ref("product tab/groups").get().then(
      
          (groupsSnapshot) {
            for(group)
            {groupsSnapshot.children.forEach(
            (groupSnapshot) async {
              Query groupQuery = groupSnapshot.ref
                  .child("products")
                  .orderByChild("id")
                  .equalTo(id);
              await groupQuery.get().then(
                (productsSnapshot) {
                  for (DataSnapshot product in productsSnapshot.children) {
                    ref = product.ref;
                    print("first");
                    print(ref?.path);
                  }
                },
              );
            },
          );}
          },
        );
    return ref;
  }

  Future<void> rename(String newName) async {
    DatabaseReference? ref = await getProductRef();
    print("second");
    print(ref?.path);
    await ref?.update({"name": newName});
  }

  Future<void> setTagline(String tagline) async {
    DatabaseReference? ref = await getProductRef();
    await ref?.update({"tagline": tagline});
  }

  Future<void> setLogo(Img logo) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"logo": logo.toMap()});
  }

  Future<void> setOffer(Img offer) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"offer": offer.toMap()});
  }

  Future<void> setOther(Img other) async {
    DatabaseReference? ref = await futureRef;
    await ref?.update({"other": other.toMap()});
  }
}
