import 'package:demo_catalog_app/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class DropDown extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? value;
  DropDown({Key? key, this.onChanged, this.value}) : super(key: key);
  String? selectedValue;
  List<String> items = [
    'Gujarat',
    'Maharashtra',
    'Rajasthan',
    'PD',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          focusColor: Colors.transparent,
          dropdownDecoration: BoxDecoration(
            color: kSecondaryColor,
borderRadius: 
          ),
          
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: value,
          onChanged: onChanged,
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 14,
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(15),
          //   color: Colors.grey,
          // ),
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  // return
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   children: <Widget>[
  //     // SizedBox(width: 20),
  //     Expanded(
  //       child: DropdownButton(
  //         isExpanded: true,
  //         underline: SizedBox.shrink(),
  //         alignment: Alignment.center,
  //         icon: Icon(Icons.arrow_drop_down),
  //         value: value,
  //         items: ['Gujarat', 'Maharashtra', 'Rajasthan', 'PD']
  //             .map<DropdownMenuItem<String>>((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: TextWidget(text: value),
  //           );
  //         }).toList(),
  //         onChanged: onChanged,
  //       ),
  //     ),
  //   ],
  // );
}
