import 'package:flutter/material.dart';

import 'test.dart';

void main() {
  runApp(TestWidget());
}
class TestWidget extends StatelessWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        firebase(),
      ),
    );
  }
}
