import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/models/tab_titles.dart';
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
    Locations.locations = [
      "Gujarat",
      "Maharashtra",
      "Rajasthan",
      "PE",
    ];
    TabTitles.tabTitles = [
      "Seasonal Scheme",
      "Price List",
      "Product Offer",
      "Others"
    ];
    var locationIndex = ref.watch(locationIndexProvider.state);
    var tabIndex = ref.watch(tabIndexProvider.state);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  locationIndex.state = 0;
                  tabIndex.state = 0;
                },
                child: Container(
                  child: Text("Get Data"),
                ),
              ),
              InkWell(
                onTap: () {
                  TabsController(reader: ref.read).add(index: 0);
                },
                child: Container(
                  child: Text("Add Tab"),
                ),
              ),
              InkWell(
                onTap: () {
                  TabsController(reader: ref.read).delete(index: 0);
                },
                child: Container(
                  child: Text("Delete Tab"),
                ),
              ),
              InkWell(
                onTap: () {
                  TabsController(reader: ref.read)
                      .reorder(oldIndex: 1, newIndex: 4);
                },
                child: Container(
                  child: Text("Reorder Tab"),
                ),
              ),
              InkWell(
                onTap: () {
                  TabsController(reader: ref.read)
                      .reorder(oldIndex: 1, newIndex: 4);
                },
                child: Container(
                  child: Text("reanme Tab"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
