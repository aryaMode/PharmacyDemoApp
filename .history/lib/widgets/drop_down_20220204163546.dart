import 'package:flutter/material.dart';

import 'text_widget.dart';

class DropDown extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? value;
  DropDown({Key? key, this.onChanged, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // SizedBox(width: 20),
        Expanded(
          child: DropdownButton(
            isExpanded: true,
            underline: SizedBox.shrink(),
            alignment: Alignment.center,
            icon: Icon(Icons.arrow_drop_down),
            value: value,
            items: ['Gujarat', 'Maharashtra', 'Rajasthan', 'PD']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: TextWidget(text: value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
