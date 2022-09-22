import 'package:firebase_database/firebase_database.dart';

class ProductController {
  final String id;
  late Future<DatabaseReference> ref;
  ProductController({required this.id});
  Future<DatabaseReference> getDatabaseRef (){

  }
}
 