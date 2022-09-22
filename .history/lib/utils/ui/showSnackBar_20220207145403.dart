import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("$e"),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
