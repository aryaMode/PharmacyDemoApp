import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final Widget? child;
  const DialogBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      child: child,
    );
  }
}
