import '../../data/models/onboarding_submission_request.dart';
import '../../data/models/onboarding_submission_response.dart';
import '../repositories/onboarding_submission_repository.dart';

abstract class SubmitOnboardingUseCase {
  Future<OnboardingSubmissionResponse> call(
    OnboardingSubmissionRequest request,
  );
}

class SubmitOnboardingUseCaseImpl implements SubmitOnboardingUseCase {
  final OnboardingSubmissionRepository _repository;

  SubmitOnboardingUseCaseImpl(this._repository);

  @override
  Future<OnboardingSubmissionResponse> call(
    OnboardingSubmissionRequest request,
  ) async {
    return await _repository.submitOnboarding(request);
  }
}
