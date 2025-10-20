import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel_guide/core/models/countries_item.dart';
import 'package:travel_guide/core/models/country_city.dart';

part 'onboading_view_state.freezed.dart';

@freezed
abstract class OnboadingViewState with _$OnboadingViewState {
  const OnboadingViewState._();

  const factory OnboadingViewState({
    @Default([]) List<CountriesItem> items,
    CountryCity? selectedItem,
  }) = _OnboadingViewState;
}
