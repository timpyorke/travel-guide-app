import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Lightweight wrapper around geolocation and reverse-geocoding lookups.
class DeviceLocationService {
  const DeviceLocationService();

  Future<DeviceLocationResult?> detectCurrentLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isEmpty) {
        return null;
      }

      final Placemark bestGuess = placemarks.firstWhere(
        (Placemark placemark) =>
            (placemark.locality?.isNotEmpty ?? false) &&
            (placemark.country?.isNotEmpty ?? false),
        orElse: () => placemarks.first,
      );

      final String? country = bestGuess.country;
      final String? city = bestGuess.locality ??
          bestGuess.subAdministrativeArea ??
          bestGuess.administrativeArea;

      if (country == null || country.isEmpty) {
        return null;
      }
      if (city == null || city.isEmpty) {
        return null;
      }

      return DeviceLocationResult(country: country, city: city);
    } on PermissionDeniedException {
      return null;
    } on TimeoutException {
      return null;
    } on Exception {
      return null;
    }
  }
}

class DeviceLocationResult {
  const DeviceLocationResult({
    required this.country,
    required this.city,
  });

  final String country;
  final String city;
}
