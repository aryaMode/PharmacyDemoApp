import 'package:demo_catalog_app/constants/colors.dart';
import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor, iconColor;
  final double size;
  const RoundedIcon({
    Key? key,
    required this.iconData,
    this.backgroundColor = kPrimaryColor,
    this.iconColor = Colors.black,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: size / 2,
      ),
    );
  }
}
