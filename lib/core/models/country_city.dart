import 'package:freezed_annotation/freezed_annotation.dart';
part 'country_city.freezed.dart';
part 'country_city.g.dart';

@freezed
abstract class CountryCity with _$CountryCity {
  const factory CountryCity({required String id, required String name}) =
      _CountryCity;

  factory CountryCity.fromJson(Map<String, dynamic> json) =>
      _$CountryCityFromJson(json);
}
