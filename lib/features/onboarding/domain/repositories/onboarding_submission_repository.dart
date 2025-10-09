import '../../data/models/onboarding_submission_request.dart';
import '../../data/models/onboarding_submission_response.dart';

abstract class OnboardingSubmissionRepository {
  Future<OnboardingSubmissionResponse> submitOnboarding(
    OnboardingSubmissionRequest request,
  );
}
