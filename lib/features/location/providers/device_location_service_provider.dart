import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/device_location_service.dart';

final Provider<DeviceLocationService> deviceLocationServiceProvider =
    Provider<DeviceLocationService>(
  (_) => const DeviceLocationService(),
);
