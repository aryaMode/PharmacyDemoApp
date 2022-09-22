import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<AsyncData<Group>>{
  GroupController(AsyncData<Group> state) : super(state);
  List<Group>retrieveGroups(){

  }
}