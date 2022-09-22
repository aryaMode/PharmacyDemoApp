import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';

class ModalTrigger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DragAndDropGridView(
      is
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
