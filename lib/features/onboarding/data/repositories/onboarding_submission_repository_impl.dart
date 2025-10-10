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
      print('📦 Full Response JSON: ${response.toJson()}');

      // Print recommended sermons specifically
      if (response.recommendedSermons != null) {
        print('🎬 RECOMMENDED SERMONS from API:');
        print('   Count: ${response.recommendedSermons!.length}');
        for (var i = 0; i < response.recommendedSermons!.length; i++) {
          final sermon = response.recommendedSermons![i];
          print('   [$i] Title: ${sermon.title}');
          print('       Description: ${sermon.description}');
          print('       Video URL: ${sermon.gcsUrl}');
          print('       Speaker: ${sermon.speaker?.name ?? "No speaker"}');
          print(
            '       Church: ${sermon.speaker?.church?.name ?? "No church"}',
          );
          print('       ---');
        }
      } else {
        print('⚠️ NO recommended_sermons in response!');
      }

      return response;
    } catch (e, stackTrace) {
      print('❌ Error submitting onboarding: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
