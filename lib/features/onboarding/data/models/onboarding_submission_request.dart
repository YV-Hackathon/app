import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_submission_request.freezed.dart';
part 'onboarding_submission_request.g.dart';

@freezed
class OnboardingSubmissionRequest with _$OnboardingSubmissionRequest {
  const factory OnboardingSubmissionRequest({
    @JsonKey(name: 'user_id') required int userId,
    required OnboardingAnswers answers,
  }) = _OnboardingSubmissionRequest;

  factory OnboardingSubmissionRequest.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSubmissionRequestFromJson(json);
}

@freezed
class OnboardingAnswers with _$OnboardingAnswers {
  const factory OnboardingAnswers({
    required List<int> speakers,
    @JsonKey(name: 'bible_reading_preference')
    required String bibleReadingPreference,
    @JsonKey(name: 'teaching_style_preference')
    required String teachingStylePreference,
    @JsonKey(name: 'environment_preference')
    required String environmentPreference,
  }) = _OnboardingAnswers;

  factory OnboardingAnswers.fromJson(Map<String, dynamic> json) =>
      _$OnboardingAnswersFromJson(json);
}
