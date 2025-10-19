import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/location_repository.dart';

part 'location_repository.g.dart';

@Riverpod(keepAlive: true)
Future<LocationRepository> locationRepository() async {
  return SharedPreferencesLocationRepository();
}
