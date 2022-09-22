import 'package:flutter_riverpod/flutter_riverpod.dart';

final editableProvider = StateProvider.autoDispose<bool>((ref) => false);
final imageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
final locationIndexProvider = StateProvider<int>((ref) => -1);

final curretnTabProvider = StateProvider<String>((ref)=>)
