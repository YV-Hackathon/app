import '../../data/models/sermon_preference_request.dart';
import '../../data/models/sermon_preference_response.dart';

abstract class SermonPreferenceRepository {
  Future<SermonPreferenceResponse> submitPreference(
    SermonPreferenceRequest request,
  );
}
