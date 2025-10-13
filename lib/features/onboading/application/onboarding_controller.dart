import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../location/models/location_selection.dart';
import '../../location/providers/location_controller.dart';

const List<String> kOnboardingPreferenceOptions = <String>[
  'Culture',
  'Food & Drink',
  'Outdoors',
  'Nightlife',
  'Wellness',
  'Family Friendly',
];

const Object _noParam = Object();

class OnboardingState {
  const OnboardingState({
    required List<String> countryOptions,
    required List<String> cityOptions,
    required Set<String> selectedPreferences,
    this.selectedCountry,
    this.selectedCity,
    this.isLoading = false,
    this.isSubmitting = false,
    this.isDirty = false,
    this.errorMessage,
  }) : countryOptions = countryOptions,
       cityOptions = cityOptions,
       selectedPreferences = selectedPreferences;

  final List<String> countryOptions;
  final List<String> cityOptions;
  final String? selectedCountry;
  final String? selectedCity;
  final Set<String> selectedPreferences;
  final bool isLoading;
  final bool isSubmitting;
  final bool isDirty;
  final String? errorMessage;

  bool get canSubmit =>
      !isLoading &&
      !isSubmitting &&
      selectedCountry != null &&
      selectedCity != null;

  OnboardingState copyWith({
    List<String>? countryOptions,
    List<String>? cityOptions,
    Object? selectedCountry = _noParam,
    Object? selectedCity = _noParam,
    Set<String>? selectedPreferences,
    bool? isLoading,
    bool? isSubmitting,
    bool? isDirty,
    Object? errorMessage = _noParam,
  }) {
    return OnboardingState(
      countryOptions: countryOptions ?? this.countryOptions,
      cityOptions: cityOptions ?? this.cityOptions,
      selectedCountry: identical(selectedCountry, _noParam)
          ? this.selectedCountry
          : selectedCountry as String?,
      selectedCity: identical(selectedCity, _noParam)
          ? this.selectedCity
          : selectedCity as String?,
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDirty: isDirty ?? this.isDirty,
      errorMessage: identical(errorMessage, _noParam)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

class OnboardingSubmitResult {
  const OnboardingSubmitResult._({
    required this.isSuccess,
    this.message,
    this.error,
  });

  const OnboardingSubmitResult.success() : this._(isSuccess: true);

  OnboardingSubmitResult.failure(String message, [Object? error])
    : this._(isSuccess: false, message: message, error: error);

  final bool isSuccess;
  final String? message;
  final Object? error;
}

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController(this._ref) : super(_buildInitialState(_ref)) {
    _locationSubscription = _ref.listen<AsyncValue<LocationSelection?>>(
      locationControllerProvider,
      (AsyncValue<LocationSelection?>? _, AsyncValue<LocationSelection?> next) {
        _handleLocationState(next);
      },
      fireImmediately: true,
    );
  }

  final Ref _ref;
  late final ProviderSubscription<AsyncValue<LocationSelection?>>
  _locationSubscription;

  @override
  void dispose() {
    _locationSubscription.close();
    super.dispose();
  }

  static OnboardingState _buildInitialState(Ref ref) {
    final LocationController locationController = ref.read(
      locationControllerProvider.notifier,
    );
    final AsyncValue<LocationSelection?> locationState = ref.read(
      locationControllerProvider,
    );
    final LocationSelection? selection = locationState.value;
    final String? selectedCountry = selection?.country;
    final List<String> cityOptions = selectedCountry == null
        ? const <String>[]
        : locationController.citiesForCountry(selectedCountry);
    final String? selectedCity = selection?.city;
    final String? sanitizedCity =
        selectedCity != null && cityOptions.contains(selectedCity)
        ? selectedCity
        : null;

    return OnboardingState(
      countryOptions: locationController.countries,
      cityOptions: cityOptions,
      selectedCountry: selectedCountry,
      selectedCity: sanitizedCity,
      selectedPreferences: const <String>{},
      isLoading: locationState.isLoading,
    );
  }

  void updateCountry(String? country) {
    final LocationController locationController = _ref.read(
      locationControllerProvider.notifier,
    );
    final List<String> cityOptions = country == null
        ? const <String>[]
        : locationController.citiesForCountry(country);
    final String? currentCity = state.selectedCity;
    final String? resolvedCity =
        currentCity != null && cityOptions.contains(currentCity)
        ? currentCity
        : null;

    state = state.copyWith(
      selectedCountry: country,
      cityOptions: cityOptions,
      selectedCity: resolvedCity,
      isDirty: true,
      errorMessage: null,
    );
  }

  void updateCity(String? city) {
    if (city != null && !state.cityOptions.contains(city)) {
      return;
    }
    state = state.copyWith(
      selectedCity: city,
      isDirty: true,
      errorMessage: null,
    );
  }

  void togglePreference(String preference) {
    final Set<String> updated = state.selectedPreferences.toSet();
    if (updated.contains(preference)) {
      updated.remove(preference);
    } else {
      updated.add(preference);
    }

    state = state.copyWith(
      selectedPreferences: updated,
      isDirty: true,
      errorMessage: null,
    );
  }

  Future<OnboardingSubmitResult> submit() async {
    if (!state.canSubmit) {
      const String message = 'Please select both country and city.';
      state = state.copyWith(errorMessage: message);
      return OnboardingSubmitResult.failure(message);
    }

    final LocationController locationController = _ref.read(
      locationControllerProvider.notifier,
    );

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      await locationController.setLocation(
        country: state.selectedCountry!,
        city: state.selectedCity!,
      );
      state = state.copyWith(isSubmitting: false, isDirty: false);
      return const OnboardingSubmitResult.success();
    } catch (error) {
      final String message = 'Failed to save location: $error';
      state = state.copyWith(isSubmitting: false, errorMessage: message);
      return OnboardingSubmitResult.failure(message, error);
    }
  }

  Future<OnboardingSubmitResult> clearSelection() async {
    final LocationController locationController = _ref.read(
      locationControllerProvider.notifier,
    );

    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      await locationController.clearLocation();
      state = state.copyWith(
        selectedCountry: null,
        selectedCity: null,
        cityOptions: const <String>[],
        isSubmitting: false,
        isDirty: false,
      );
      return const OnboardingSubmitResult.success();
    } catch (error) {
      final String message = 'Failed to clear location: $error';
      state = state.copyWith(isSubmitting: false, errorMessage: message);
      return OnboardingSubmitResult.failure(message, error);
    }
  }

  void _handleLocationState(AsyncValue<LocationSelection?> next) {
    if (state.isDirty && !state.isSubmitting) {
      state = state.copyWith(isLoading: next.isLoading);
      return;
    }

    final LocationController locationController = _ref.read(
      locationControllerProvider.notifier,
    );
    final LocationSelection? selection = next.value;
    final String? country = selection?.country;
    final List<String> cityOptions = country == null
        ? const <String>[]
        : locationController.citiesForCountry(country);
    final String? rawCity = selection?.city;
    final String? city = rawCity != null && cityOptions.contains(rawCity)
        ? rawCity
        : null;

    state = state.copyWith(
      countryOptions: locationController.countries,
      cityOptions: cityOptions,
      selectedCountry: country,
      selectedCity: city,
      isLoading: next.isLoading,
      isDirty: false,
    );
  }
}

final onboardingControllerProvider =
    StateNotifierProvider.autoDispose<OnboardingController, OnboardingState>(
      (ref) => OnboardingController(ref),
    );
