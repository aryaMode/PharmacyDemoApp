import 'dart:collection';

import 'package:demo_catalog_app/modules/Tabs/models/folder.dart';

class Tab {
  String name;
  SplayTreeMap<String, Folder> folders;
  int index;
}
