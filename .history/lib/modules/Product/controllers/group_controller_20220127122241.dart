import 'package:demo_catalog_app/modules/Product/models/group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupController extends StateNotifier<List<Group>>{
  GroupController(List<Group> state) : super(state);
  List<Group> retrieveGroups(){

  }
}