import 'package:demo_catalog_app/modules/Auth/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<AuthUs>((ref)=>AuthUser());