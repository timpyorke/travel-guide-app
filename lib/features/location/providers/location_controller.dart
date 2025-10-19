import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/location_data.dart';
import '../models/location_selection.dart';
import '../services/device_location_service.dart';
import '../../../core/providers/device_location_service_provider.dart';
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

  Future<void> syncWithDeviceLocation() async {
    final DeviceLocationService service =
        ref.read(deviceLocationServiceProvider);
    final DeviceLocationResult? detected =
        await service.detectCurrentLocation();
    if (detected == null) {
      return;
    }

    final LocationSelection? normalized = _normalizeSelection(detected);
    if (normalized == null) {
      return;
    }

    final repository = await ref.watch(locationRepositoryProvider.future);
    final LocationSelection? existing = await repository.load();
    if (existing != null &&
        existing.country == normalized.country &&
        existing.city == normalized.city) {
      return;
    }

    try {
      await repository.save(normalized);
      state = AsyncValue.data(normalized);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  LocationSelection? _normalizeSelection(DeviceLocationResult result) {
    final String? matchingCountry = kCountryCityOptions.keys.firstWhere(
      (String country) =>
          country.toLowerCase().trim() == result.country.toLowerCase().trim(),
      orElse: () => '',
    );

    if (matchingCountry == null || matchingCountry.isEmpty) {
      return null;
    }

    final List<String> cityOptions =
        kCountryCityOptions[matchingCountry] ?? <String>[];
    final String lowerTarget = result.city.toLowerCase().trim();
    String? matchingCity;
    for (final String candidate in cityOptions) {
      if (candidate.toLowerCase().trim() == lowerTarget) {
        matchingCity = candidate;
        break;
      }
    }

    matchingCity ??= cityOptions.isNotEmpty ? cityOptions.first : null;
    if (matchingCity == null || matchingCity.isEmpty) {
      return null;
    }

    return LocationSelection(country: matchingCountry, city: matchingCity);
  }
}
