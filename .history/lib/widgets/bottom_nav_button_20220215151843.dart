import 'package:auto_size_text/auto_size_text.dart';
import 'package:demo_catalog_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  final String tileText;
  final void Function()? onPress;
  final TextStyle textStyle;
  final double? width, height;
  final Color? color;

  const BottomNavButton({
    Key? key,
    required this.tileText,
    this.onPress,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
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
          padding: const EdgeInsets.all(5),
          child: Center(
            child: AutoSizeText(
              tileText,
              style: textStyle,
            ),
          ),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: const Color(0x20FFFFFF)),
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
      textStyle: style ?? textStyle,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
    );
  }
}
