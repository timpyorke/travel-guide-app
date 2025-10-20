import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_guide/core/models/country_city.dart';

part 'countries_item.freezed.dart';
part 'countries_item.g.dart';

@freezed
abstract class CountriesItem with _$CountriesItem {
  const factory CountriesItem({
    required String id,
    required String name,
    required String flag,
    @Default(<CountryCity>[]) List<CountryCity> cities,
  }) = _CountriesItem;

  factory CountriesItem.fromJson(Map<String, dynamic> json) =>
      _$CountriesItemFromJson(json);
}
