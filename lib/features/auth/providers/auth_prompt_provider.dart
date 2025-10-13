import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks whether the automatic auth prompt has already been shown/dismissed.
final StateProvider<bool> authPromptDismissedProvider =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return false;
});
