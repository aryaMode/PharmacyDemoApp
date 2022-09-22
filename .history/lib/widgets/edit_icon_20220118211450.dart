import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'elevated_icon_button.dart';

class EditIcon extends ConsumerWidget {
  final double padding;

  const EditIcon({Key? key, this.padding = 0}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: ElevatedIconButton(
        inheritedPadding: padding,
        icon: Icons.edit,
        active: ref.watch(editableProvider),
        onPressed:()=> ref.read(editableProvider.state).state = !editable ,
        
      ),
    );
  }
}