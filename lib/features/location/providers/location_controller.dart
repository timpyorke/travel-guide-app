import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/location_data.dart';
import '../models/location_selection.dart';
import 'location_repository.dart';

part 'location_controller.g.dart';

@Riverpod(keepAlive: true)
class LocationController extends _$LocationController {
  @override
  Future<LocationSelection?> build() async {
    final repository = await ref.watch(locationRepositoryProvider.future);
    return repository.load();
  }

  List<String> get countries => kCountryCityOptions.keys.toList();

  List<String> citiesForCountry(String country) =>
      kCountryCityOptions[country] ?? <String>[];

  Future<void> setLocation({
    required String country,
    required String city,
  }) async {
    final selection = LocationSelection(country: country, city: city);
    state = const AsyncValue.loading();
    final repository = await ref.watch(locationRepositoryProvider.future);
    await repository.save(selection);
    state = AsyncValue.data(selection);
  }

  Future<void> clearLocation() async {
    state = const AsyncValue.loading();
    final repository = await ref.watch(locationRepositoryProvider.future);
    await repository.clear();
    state = const AsyncValue.data(null);
  }
}
