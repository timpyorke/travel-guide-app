import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_guide/core/models/countries_item.dart';
import 'package:travel_guide/core/models/country_city.dart';
import 'package:travel_guide/features/onboading/models/onboading_view_state.dart';

class OnboardingViewModel extends Notifier<OnboadingViewState> {
  @override
  OnboadingViewState build() {
    Future.microtask(loadInit);
    return state;
  }

  void loadInit() {
    state = state.copyWith(
      items: [
        // Example data; replace with actual data fetching logic
        CountriesItem(
          name: 'Thailand',
          cities: [
            CountryCity(name: 'Bangkok', id: 'bangkok'),
            CountryCity(name: 'Phuket', id: 'phuket'),
          ],
          id: 'thailand',
          flag: '🇹🇭',
        ),
        CountriesItem(
          name: 'Japan',
          cities: [
            CountryCity(name: 'Tokyo', id: 'tokyo'),
            CountryCity(name: 'Osaka', id: 'osaka'),
          ],
          id: 'japan',
          flag: '🇯🇵',
        ),
      ],
    );
  }
}

final onboardingViewModelProvider =
    NotifierProvider<OnboardingViewModel, OnboadingViewState>(
      () => OnboardingViewModel(),
    );
