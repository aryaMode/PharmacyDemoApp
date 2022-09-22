import 'package:demo_catalog_app/constants/text_styles.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class BottomNav
Button extends StatelessWidget {
  final String tileText;
  final void Function()? onPress;
  final TextStyle? style;
  final double? width, height;
  final Color? color;

  const BottomNavButton({
    Key? key,
    required this.tileText,
    this.onPress,
    this.style,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Container(
          child: Center(
            child: TextWidget(
              text: tileText,
              textStyle: kProductButtonTextStyle,
            ),
          ),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Color(0x20FFFFFF)),
          ),
        ),
      ),
    );
  }
}