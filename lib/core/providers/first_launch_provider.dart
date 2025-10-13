import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_provider.dart';

const String _kHasLaunchedKey = 'has_launched_before';

class FirstLaunchNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final SharedPreferences prefs =
        await ref.watch(sharedPreferencesProvider.future);
    final bool hasLaunched = prefs.getBool(_kHasLaunchedKey) ?? false;
    return !hasLaunched;
  }

  Future<void> markSeen() async {
    final SharedPreferences prefs =
        await ref.read(sharedPreferencesProvider.future);
    await prefs.setBool(_kHasLaunchedKey, true);
    state = const AsyncValue.data(false);
  }
}

final AsyncNotifierProvider<FirstLaunchNotifier, bool>
    firstLaunchNotifierProvider =
    AsyncNotifierProvider<FirstLaunchNotifier, bool>(
  FirstLaunchNotifier.new,
);
