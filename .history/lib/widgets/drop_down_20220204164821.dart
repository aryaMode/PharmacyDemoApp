import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class DropDown extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? value;
  DropDown({Key? key, this.onChanged, this.value}) : super(key: key);
  String? selectedValue;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
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
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
          icon: const Icon(
            Icons.arrow_drop_down,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.grey,
          iconDisabledColor: Colors.grey,
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
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
