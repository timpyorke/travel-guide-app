import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/location_selection.dart';

abstract class LocationRepository {
  Future<LocationSelection?> load();
  Future<void> save(LocationSelection selection);
  Future<void> clear();
}

class SharedPreferencesLocationRepository implements LocationRepository {
  SharedPreferencesLocationRepository();

  static const String _storageKey = 'location_selection';

  @override
  Future<LocationSelection?> load() async {
    final pref = await SharedPreferences.getInstance();
    final String? raw = pref.getString(_storageKey);
    if (raw == null) {
      return null;
    }
    try {
      final Map<String, Object?> json = jsonDecode(raw) as Map<String, Object?>;
      return LocationSelection.fromJson(json);
    } on FormatException {
      await clear();
      return null;
    }
  }

  @override
  Future<void> save(LocationSelection selection) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_storageKey, jsonEncode(selection.toJson()));
  }

  @override
  Future<void> clear() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_storageKey);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferencesLocationRepository>(
  (ref) => SharedPreferencesLocationRepository(),
);
