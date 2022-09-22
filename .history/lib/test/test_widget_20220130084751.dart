import 'package:demo_catalog_app/modules/Product/controllers/group_controller.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestWidget extends ConsumerStatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends ConsumerState<TestWidget> {
  bool chaloTest = true;
  @override
  Widget build(BuildContext context) {
    // var asyncValue = ref.watch(streamProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
              Container(
                child: chaloTest
                    ? InkWell(
                        onTap: () async {
                          setState(() {
                            chaloTest = !chaloTest;
                          });
                          for (int i = 0; i < 6; i++) {
                            await GroupsController().add(i);
                          }
                          setState(() {
                            chaloTest = !chaloTest;
                          });
                        },
                        child: Text("Add"),
                      )
                    : CircularProgressIndicator(),
              ),
              Container(
                child: InkWell(
                  onTap: () async {
                    for (int i = 0; i < 6; i++) {
                      await GroupsController().delete(5 - i);
                    }
                  },
                  child: Text("delete"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    GroupController(index: 1).rename("doggy");
                  },
                  child: Text("rename"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () async {
                    await GroupsController().reorder(4, 1);
                  },
                  child: Text("reorder"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () async {
                    await GroupController().reorder(4, 1);
                  },
                  child: Text("Add product"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () async {
                    await GroupsController().reorder(4, 1);
                  },
                  child: Text("Delete product"),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () async {
                    await GroupsController().reorder(4, 1);
                  },
                  child: Text("reorder product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
