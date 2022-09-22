import 'dart:collection';

import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';
import 'package:universal_html/html.dart';

class Tab {
  String name;
  SplayTreeMap<String, Location> folders;
  int index;
}
