import 'package:demo_catalog_app/constants/colors.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class ElevatedIcon extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  
  final Color? color;
  final bool active;
  const ElevatedIcon(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.color = Colors.white,
      this.active = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(icon, color: active ? color : Colors.grey, size: size,)),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        elevation: active ? 6 : 0,
        primary: active ? kSecondaryColor : Colors.grey.shade800,
      ),
    );
  }
}
