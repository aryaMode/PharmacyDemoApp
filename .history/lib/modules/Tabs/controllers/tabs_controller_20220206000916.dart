import 'package:demo_catalog_app/utils/helper/firebase_db_helper.dart';
import 'package:firebase_database/firebase_database.dart';

class TabsController{
  DatabaseReference ref =
      FirebaseDBHelper.database.ref("tab/groups");
}