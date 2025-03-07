import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationCounter = StateProvider.autoDispose<int>((ref) {
  return 0;
});
