import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncString = ref.watch(futureProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: asyncString.when(
              data: (value) => Text(value),
              error: (e, st) => Text('Error: $e'),
              loading: () => CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
