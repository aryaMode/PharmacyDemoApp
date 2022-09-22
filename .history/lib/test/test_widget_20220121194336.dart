import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncString = ref.watch(futureProvider);
    return Container(
      child: asyncString.maybeWhen(
        data:(value) => Text(value) ,
        error: error,
        loading: loading,
      ),
    );
  }
}
