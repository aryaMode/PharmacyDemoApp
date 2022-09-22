import 'package:demo_catalog_app/modules/Product/repositories/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  int indexToBeAdded = 0;
    // var asyncValue = ref.watch(streamProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    GroupRepository.addEmpty(21);
                  },
                  child: Text("Add"),
                ),
                // asyncValue.when(
                //   data: (value) => Text(value.toString()),
                //   error: (e, st) => Text('Error: $e'),
                //   loading: () => CircularProgressIndicator(),
                // ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    GroupRepository.delete(21);
                  },
                  child: Text("delete"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    GroupRepository.rename(21, "doggy");
                  },
                  child: Text("rename"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    // GroupRepository.reorder(21, );
                  },
                  child: Text("reorder"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
