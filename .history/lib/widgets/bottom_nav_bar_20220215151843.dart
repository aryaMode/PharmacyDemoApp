import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> widgets;
  final EdgeInsetsGeometry? margin, padding;
  const BottomNavBar({
    Key? key,
    this.backgroundColor,
    required this.widgets,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      color: backgroundColor,
      width: MediaQuery.of(context).size.width,
      height: kBottomBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets,
      ),
    );
  }
}
