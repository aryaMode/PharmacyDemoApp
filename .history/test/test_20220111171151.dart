import 'dart:convert';
main() {
  var lists = json.decode('[{"1":123,"2":122,3:411},{1:123,2:122,3:411}]');
  print(lists.runtimeType);
  for(var i = 0; i < lists.length; i++) {
    print('L $i');
  	for(var j in lists[i]) {
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
