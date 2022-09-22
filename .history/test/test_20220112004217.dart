import 'dart:convert';

main() {
  var lists = json.decode('[[{"name": balma}]]');
  print(lists.runtimeType);
  for (var i = 0; i < lists.length; i++) {
    print('L $i');
    for (var j in lists) {
      print(j);
    }
  }
}

// import 'dart:convert';
// main() {
//   var lists = json.decode('[[123],[122],[411]]');
//   print(lists);
//   for(var i = 0; i < lists.length; i++) {
//     print('L $i');
//   	for(var j in lists[i]) {
//       print(j);      
//     }
//   }
// }
