import 'package:flutter/material.dart';

import 'elevated_icon_button.dart';

class AddRemoveIconRow extends StatelessWidget {
  final dynamic Function()? onAdd, onDelete;
  final double inheritedPadding;
  final int listLength;
  
  const AddRemoveIconRow({
    Key? key,
    dynamic Function()? onAdd,
    dynamic Function()? onDelete,
    double inheritedPadding = 0,
    required int listLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedIconButton(
            inheritedPadding: inheritedPadding,
            icon: Icons.remove,
            active: listLength != 1,
            onPressed: onDelete),
        ElevatedIconButton(
            inheritedPadding: inheritedPadding,
            icon: Icons.add,
            active: true,
            onPressed: onDelete),
      ],
    );
  }
}
