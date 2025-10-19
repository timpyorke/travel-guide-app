import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_guide/features/onboading/models/onboading_view_state.dart';

class OnboardingViewModel extends Notifier<OnboadingViewState> {
  @override
  OnboadingViewState build() {
    return const OnboadingViewState();
  }

  void setItems(List<String> items) {
    state = state.copyWith(items: items);
  }
}
