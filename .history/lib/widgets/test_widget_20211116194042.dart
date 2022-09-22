import 'package:flutter/material.dart';

class ModalTrigger extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        _showModalBottomSheet(context);
      },
      fillColor: Colors.black,
      constraints: BoxConstraints(minHeight: 50),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      textStyle: TextStyle(
        fontSize: 16,
        fontFamily: 'OpenSans',
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      child: Text('Hire Baba Yaga!'),
    );
  }
}