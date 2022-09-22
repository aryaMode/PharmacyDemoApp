import 'dart:collection';

import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:demo_catalog_app/modules/Tabs/models/locationFolders.dart';
import 'package:universal_html/html.dart';

class Tab {
  String name;
  SplayTreeMap<String, LocationFolders> folders;
  int index;
}
