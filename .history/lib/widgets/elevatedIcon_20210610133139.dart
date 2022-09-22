import 'package:flutter/material.dart';

class ElivatedIcon extends StatelessWidget {
  const ElivatedIcon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
                  children: <Widget>[
                    Positioned(
                      left: 1.0,
                      top: 2.0,
                      child: Icon(icon, color: Colors.black54),
                    ),
                    Icon(icon, color: Colors.white),
                  ],
                ),
  }
}