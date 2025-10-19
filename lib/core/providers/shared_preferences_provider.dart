import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  SharedPreferencesProvider();

  static const String keyCity = 'key_city';
  static const String keyIsFirstLanch = 'key_is_first_launch';

  Future<String> getCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyCity) ?? '';
  }

  void setCity() {}

  Future<bool> isFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsFirstLanch) ?? false;
  }

  void setFirstLaunch(bool isFirstLaunch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(keyIsFirstLanch, isFirstLaunch);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferencesProvider>((ref) {
  return SharedPreferencesProvider();
});
