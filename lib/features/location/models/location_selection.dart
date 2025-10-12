import 'package:meta/meta.dart';

@immutable
class LocationSelection {
  const LocationSelection({
    required this.country,
    required this.city,
  });

  final String country;
  final String city;

  LocationSelection copyWith({
    String? country,
    String? city,
  }) {
    return LocationSelection(
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }

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
