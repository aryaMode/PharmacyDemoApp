import 'package:demo_catalog_app/constants/decorations.dart';
import 'package:demo_catalog_app/constants/dimensions.dart';
import 'package:demo_catalog_app/utils/helper/dimension_helper.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getScreenHeight(context) * 0.2,
      width: getScreenWidth(context) * 0.16,
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: const TextField(
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: searchFieldInputDecoration,
      ),
    );
  }
}
