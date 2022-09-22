
import 'package:firebase_database/firebase_database.dart';

main() async {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref("product tab/groups");
  Query query = ref.orderByChild("name");
  var snapshot = await query.get();
  print(snapshot.value);
}

