import 'package:flutter_riverpod/legacy.dart';

/// Tracks whether the automatic auth prompt has already been shown/dismissed.
final StateProvider<bool> authPromptDismissedProvider = StateProvider<bool>((
  ref,
) {
  return false;
});
