import '../../../../core/api/api_client.dart';
import '../../domain/repositories/sermon_preference_repository.dart';
import '../models/sermon_preference_request.dart';
import '../models/sermon_preference_response.dart';

class SermonPreferenceRepositoryImpl implements SermonPreferenceRepository {
  final ApiClient _apiClient;

  SermonPreferenceRepositoryImpl(this._apiClient);

  @override
  Future<SermonPreferenceResponse> submitPreference(
    SermonPreferenceRequest request,
  ) async {
    try {
      print('👍👎 Submitting sermon preference...');
      print('📋 Request: ${request.toJson()}');

      final response = await _apiClient.submitSermonPreference(request);

      print('✅ Preference submitted successfully!');
      print('📦 Response: ${response.toJson()}');

      return response;
    } catch (e, stackTrace) {
      print('❌ Error submitting preference: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }
}
