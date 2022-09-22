import 'package:demo_catalog_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  final String tileText;
  final void Function()? onPress;
  final TextStyle? textStyle;
  final double? width, height;
  final Color? color;
  final 
  const BottomNavButton({
    Key? key,
    required this.tileText,
    this.onPress,
    this.textStyle,
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
          padding: Padding(
            padding: padding,
          ),
          child: Center(
            child: TextWidget(
              editable: false,
              text: tileText,
              textStyle: textStyle,
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

  BottomNavButton copyWith({
    String? tileText,
    void Function()? onPress,
    TextStyle? style,
    double? width,
    height,
    Color? color,
  }) {
    return BottomNavButton(
      tileText: tileText ?? this.tileText,
      onPress: onPress ?? this.onPress,
      textStyle: style ?? this.textStyle,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
    );
  }
}
