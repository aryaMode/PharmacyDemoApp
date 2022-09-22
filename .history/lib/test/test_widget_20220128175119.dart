import 'package:demo_catalog_app/modules/Product/repositories/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test.dart';

class TestWidget extends ConsumerStatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends ConsumerState<TestWidget> {
  @override
  Widget build(BuildContext context) {
    // var asyncValue = ref.watch(streamProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < 6;i++){ GroupRepository.addEmpty();
                    });
                  },
                  child: Text(indexToBeAdded.toString()),
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
                    GroupRepository.reorder(1, 4);
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
