import 'package:flutter/material.dart';

import 'elevated_icon_button.dart';

class EditIcon extends StatelessWidget {
  final double padding;
  final dynamic Function()? onPressed;

  const EditIcon({Key? key, this.padding = 0, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: ElevatedIconButton(
        inheritedPadding: padding,
        icon: Icons.edit,
        active: editable,
        onPressed: onPressed ,
        
      ),
    );
  }
}