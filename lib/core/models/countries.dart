import 'package:freezed_annotation/freezed_annotation.dart';

import 'countries_item.dart';

part 'countries.freezed.dart';
part 'countries.g.dart';

@freezed
abstract class Countries with _$Countries {
  const factory Countries({
    @Default(<CountriesItem>[]) List<CountriesItem> countries,
  }) = _Countries;

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);
}
