import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_selection.freezed.dart';

@freezed
abstract class LocationSelection with _$LocationSelection {
  const factory LocationSelection({
    required String country,
    required String city,
  }) = _LocationSelection;

  const LocationSelection._();

  Map<String, String> toJson() => <String, String>{
    'country': country,
    'city': city,
  };

  static LocationSelection? fromJson(Map<String, Object?> json) {
    final String? country = json['country'] as String?;
    final String? city = json['city'] as String?;
    if (country == null || city == null) {
      return null;
    }
    return LocationSelection(country: country, city: city);
  }
}
