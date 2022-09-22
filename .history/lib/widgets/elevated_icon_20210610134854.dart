import 'package:demo_catalog_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ElevatedIcon extends StatelessWidget {
  final IconData icon;
  const ElevatedIcon({Key? key, required this.icon}) : super(key: key);

  @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Positioned(
//           left: 1.0,
//           top: 2.0,
//           child: Icon(icon, color: Colors.black),
//         ),
//         Icon(icon, color: Colors.white),
//       ],
//     );
//   }
// }

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Icon(icon, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: kPrimaryColor,
      ),
    );
  }
}
