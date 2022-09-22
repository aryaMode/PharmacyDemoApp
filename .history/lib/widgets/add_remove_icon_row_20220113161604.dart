import 'package:flutter/material.dart';

import 'elevated_icon_button.dart';

class AddRemoveIconRow extends StatelessWidget {
  final dynamic Function()? onAdd, onDelete;
  final double inheritedPadding;
  final int? listLength;
  final MainAxisAlignment mainAxisAlignment;

  const AddRemoveIconRow({
    Key? key,
    this.onAdd,
    this.onDelete,
    this.inheritedPadding = 0,
    required this.listLength,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        ElevatedIconButton(
            inheritedPadding: inheritedPadding,
            icon: Icons.remove,
            active: listLength != 0,
            onPressed: listLength!=0 onDelete),
        ElevatedIconButton(
            inheritedPadding: inheritedPadding,
            icon: Icons.add,
            active: true,
            onPressed: onAdd),
      ],
    );
  }
}
