import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboading_view_state.freezed.dart';

@freezed
abstract class OnboadingViewState with _$OnboadingViewState {
  const OnboadingViewState._();

  const factory OnboadingViewState({
    @Default(<String>[]) List<String> items,
    String? selectedItem,
  }) = _OnboadingViewState;
}
