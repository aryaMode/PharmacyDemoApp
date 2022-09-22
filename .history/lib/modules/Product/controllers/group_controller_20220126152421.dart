import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<AsyncData<List<Group>>>{
  GroupController(AsyncData<List<Group>> state) : super(state);
  AsyncData<List<Group>> retrieveGroups(){
    
  }
}