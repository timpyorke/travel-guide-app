import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/location_repository.dart';

part 'location_repository.g.dart';

@Riverpod(keepAlive: true)
Future<LocationRepository> locationRepository(LocationRepositoryRef ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return SharedPreferencesLocationRepository(prefs);
}
