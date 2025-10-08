import 'package:freezed_annotation/freezed_annotation.dart';
import 'speaker.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default([]) List<Speaker> speakers,
    @Default([]) List<String> selectedSpeakerIds,
    @Default(0) int currentStep,
    @Default(false) bool isLoading,
    String? error,
  }) = _OnboardingState;
}



