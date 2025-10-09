import '../../../../core/api/api_client.dart';
import '../../domain/repositories/onboarding_submission_repository.dart';
import '../models/onboarding_submission_request.dart';
import '../models/onboarding_submission_response.dart';

class OnboardingSubmissionRepositoryImpl
    implements OnboardingSubmissionRepository {
  final ApiClient _apiClient;

  OnboardingSubmissionRepositoryImpl(this._apiClient);

  @override
  Future<OnboardingSubmissionResponse> submitOnboarding(
    OnboardingSubmissionRequest request,
  ) async {
    try {
      print('📤 Submitting onboarding data...');
      print('📋 Request: ${request.toJson()}');

      final response = await _apiClient.submitOnboarding(request);

      print('✅ Onboarding submission successful!');
      print('📦 Response: ${response.toJson()}');

      return response;
    } catch (e, stackTrace) {
      print('❌ Error submitting onboarding: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
