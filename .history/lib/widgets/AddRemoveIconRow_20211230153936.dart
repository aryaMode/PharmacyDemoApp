
import 'package:flutter/material.dart';

import 'elevated_icon_button.dart';

class AddRemoveIconRow
   extends StatelessWidget {
    const AddRemoveIconRow
    ({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return  Row(
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
  class AddRemoveIconRow({
  
  }) {
    return;
  }