import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var asyncValue = ref.watch(streamProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: 
            asyncValue.when(
              data: (value) => Text(value.toString()),
              error: (e, st) => Text('Error: $e'),
              loading: () => CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
