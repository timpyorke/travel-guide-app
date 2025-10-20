import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  SharedPreferencesProvider();

  static const String keyCity = 'key_city';
  static const String _keyHasCompletedOnboarding =
      'key_has_completed_onboarding';

  Future<String?> getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyCity);
  }

  Future<void> setCity(String city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyCity, city);
    notifyListeners();
  }

  Future<bool> isFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool hasCompleted =
        prefs.getBool(_keyHasCompletedOnboarding) ?? false;
    return !hasCompleted;
  }

  Future<void> setFirstLaunchCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool changed = !(prefs.getBool(_keyHasCompletedOnboarding) ?? false);
    if (!changed) {
      return;
    }
    await prefs.setBool(_keyHasCompletedOnboarding, true);
    notifyListeners();
  }
}

final sharedPreferencesProvider = Provider<SharedPreferencesProvider>((ref) {
  return SharedPreferencesProvider();
});
