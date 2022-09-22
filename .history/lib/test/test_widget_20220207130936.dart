import 'package:demo_catalog_app/models/img.dart';
import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/modules/Product/controllers/group_controller.dart';
import 'package:demo_catalog_app/modules/Product/controllers/groups_controller.dart';
import 'package:demo_catalog_app/modules/Product/controllers/product_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
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
    Locations.locationFromMap(
      {
        0: {"Gujarat"},
      },
    );
    var asyncValue = ref.watch(locationIndexProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  TabsController("Seasonal Scheme").add(index: 0);
                },
                child: Container(
                  child: Text("Add Tab"),
                ),
              ),
              InkWell(
                onTap: () {
                  TabsController("Seasonal Scheme").delete(index: 0);
                },
                child: Container(
                  child: Text("Delete Tab"),
                ),
              ),
              InkWell(
                onTap: () {
                  TabsController("Seasonal Scheme")
                      .reorder(oldIndex: 1, newIndex: 4);
                },
                child: Container(
                  child: Text("Reorder Tab"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
