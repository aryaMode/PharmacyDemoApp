import 'package:demo_catalog_app/models/locations.dart';
import 'package:demo_catalog_app/models/tab_titles.dart';
import 'package:demo_catalog_app/modules/Auth/firebase/auth_services.dart';
import 'package:demo_catalog_app/modules/Introduction/controlller/intro_controller.dart';
import 'package:demo_catalog_app/modules/Product/controllers/group_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/folder_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/location_folders_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tabs_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/controllers/tab_controller.dart';
import 'package:demo_catalog_app/modules/Tabs/providers/tab_providers.dart';
import 'package:demo_catalog_app/utils/providers/top_level_providers.dart';
import 'package:demo_catalog_app/widgets/text_widget.dart';
import 'package:flutter/material.dart' hide Tab, TabController;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modules/Product/controllers/groups_controller.dart';

class TestWidget extends ConsumerStatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends ConsumerState<TestWidget> {
  @override
  void initState() {
    super.initState();
    Locations.locations = [
      "Gujarat",
      "Maharashtra",
      "Rajasthan",
      "PD",
    ];
    TabTitles.tabTitles = [
      "Seasonal Scheme",
      "Price List",
      "Product Offer",
      "Others"
    ];
  }

  @override
  Widget build(BuildContext context) {
    final locationIndex = ref.watch(locationIndexProvider.state);
    final tabIndex = ref.watch(tabTitleIndexProvider.state);
    Future.delayed(Duration.zero, () {
      locationIndex.state = 0;
      tabIndex.state = 3;
    });
    final asyncTabs = ref.watch(tabsStreamProvider);
    Future.delayed(Duration.zero, () {
      asyncTabs.when(
        data: (data) {
          final tabState = ref.read(tabsProvider.state);
          tabState.state = data;
        },
        error: (e, st) => print("Error $e"),
        loading: () => {},
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  IntroImagesController().addImage(0);
                },
                child: Text("Empty Introduction"),
              ),
              InkWell(
                onTap: () {
                  GroupsController().add(index: 0);
                },
                child: Text("Empty Group"),
              ),
              InkWell(
                onTap: () {
                  for (int i = 0; i < TabTitles.tabTitles.length; i++) {
                    ref.read(tabTitleIndexProvider.state).state = i;
                    TabsController(reader: ref.read).add(index: 0);
                  }
                },
                child: Text("Empty Tabs"),
              ),
              TextFormField(
                initialValue: "Email",
                onFieldSubmitted: (changedText) {
                  email = changedText;
                },
              ),
              TextFormField(
                initialValue: "Password",
                onFieldSubmitted: (changedText) {
                  password = changedText;
                },
              ),
              InkWell(
                onTap: () {
                  if (email != null && password != null)
                    AuthServices.register(email: email!, password: password!);
                },
                child: Text("New admin"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? email, password;
}
