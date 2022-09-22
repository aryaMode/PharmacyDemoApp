import 'package:flutter/material.dart';

class ElevatedIcon extends StatelessWidget {
  final IconData icon;
  const ElevatedIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 1.0,
          top: 2.0,
          child: Icon(icon, color: Colors.),
        ),
        Icon(icon, color: Colors.white),
      ],
    );
  }
}
