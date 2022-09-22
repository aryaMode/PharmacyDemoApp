import 'package:flutter/material.dart';

Widget pageIndexIndicator(bool isCurrentPage) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    height: isCurrentPage ? 10.0 : 6.0,
    width: isCurrentPage ? 10.0 : 6.0,
    decoration: BoxDecoration(
      color: isCurrentPage ? Colors.grey : Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
