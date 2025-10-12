import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/location_selection.dart';

abstract class LocationRepository {
  Future<LocationSelection?> load();
  Future<void> save(LocationSelection selection);
  Future<void> clear();
}

class SharedPreferencesLocationRepository implements LocationRepository {
  SharedPreferencesLocationRepository(this._sharedPreferences);

  static const String _storageKey = 'location_selection';

  final SharedPreferences _sharedPreferences;

  @override
  Future<LocationSelection?> load() async {
    final String? raw = _sharedPreferences.getString(_storageKey);
    if (raw == null) {
      return null;
    }
    try {
      final Map<String, Object?> json =
          jsonDecode(raw) as Map<String, Object?>;
      return LocationSelection.fromJson(json);
    } on FormatException {
      await clear();
      return null;
    }
  }

  @override
  Future<void> save(LocationSelection selection) async {
    await _sharedPreferences.setString(
      _storageKey,
      jsonEncode(selection.toJson()),
    );
  }

  @override
  Future<void> clear() async {
    await _sharedPreferences.remove(_storageKey);
  }
}
