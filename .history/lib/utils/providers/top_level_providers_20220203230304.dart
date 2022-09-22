import 'package:flutter_riverpod/flutter_riverpod.dart';

final editableProvider = StateProvider.autoDispose<bool>((ref) => false);
final imageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);
