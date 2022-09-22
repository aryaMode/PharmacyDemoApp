import 'package:demo_catalog_app/constants/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class DropDown extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? value;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  DropDown({
    Key? key,
    this.onChanged,
    this.value,
    this.padding,
    this.textColor = Colors.white, this.items,
  }) : super(key: key);
  String? selectedValue;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          itemPadding: padding,
          isExpanded: true,
          focusColor: Colors.transparent,
          dropdownDecoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(15)),
          buttonDecoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(15)),
          buttonPadding: padding,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
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
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
        ),
      ),
    );
  }
}
