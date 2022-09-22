import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

@immutable
class GroupRepository {
  Future<List<Group>> retrieveGroups(){
    
  }
}
