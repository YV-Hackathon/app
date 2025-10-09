import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_submission_response.freezed.dart';
part 'onboarding_submission_response.g.dart';

@freezed
class OnboardingSubmissionResponse with _$OnboardingSubmissionResponse {
  const factory OnboardingSubmissionResponse({
    String? message,
    @JsonKey(name: 'user_id') int? userId,
    Map<String, dynamic>? user,
    Map<String, dynamic>? data,
  }) = _OnboardingSubmissionResponse;

  factory OnboardingSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$OnboardingSubmissionResponseFromJson(json);
}
