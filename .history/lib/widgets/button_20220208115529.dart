import 'package:demo_catalog_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function()? onPress;
  final TextStyle? style;
  final double? width, height;
  final Color? color;
  final Icon? icon;

  Button(
      {this.color,
      this.width,
      this.height,
      this.onPress,
      required this.text,
      this.style = const TextStyle(fontWeight: FontWeight.bold),
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onPress,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Text(
                    text,
                    style: style,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              icon ?? SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
