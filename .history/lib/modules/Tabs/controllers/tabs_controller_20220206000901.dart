import 'package:firebase_database/firebase_database.dart';

class TabsController{
  DatabaseReference ref =
      FirebaseDBHelper.database.ref("product tab/groups");
}