import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String?) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("$e"),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
