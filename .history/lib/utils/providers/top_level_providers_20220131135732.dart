import 'package:flutter_riverpod/flutter_riverpod.dart';

final editableProvider = StateProvider.autoDispose<bool>((ref) => false);
final selectedTabsIndicesProvider = StateProvider.autoDispose<List<int>>(();