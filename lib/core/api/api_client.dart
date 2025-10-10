import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/onboarding/data/models/question_model.dart';
import '../../features/onboarding/data/models/onboarding_submission_request.dart';
import '../../features/onboarding/data/models/onboarding_submission_response.dart';
import '../../features/onboarding/data/models/sermon_recommendation_response.dart';
import '../../features/onboarding/data/models/sermon_preference_request.dart';
import '../../features/onboarding/data/models/sermon_preference_response.dart';
import '../../features/churches/data/models/church_recommendation_response.dart';
import '../../features/churches/data/models/church_model.dart';
import '../../features/churches/data/models/featured_sermons_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/api/v1/onboarding/questions')
  Future<List<QuestionModel>> getOnboardingQuestions();

  @POST('/api/v1/onboarding/submit')
  Future<OnboardingSubmissionResponse> submitOnboarding(
    @Body() OnboardingSubmissionRequest request,
  );

  @GET('/api/v1/sermons/recommendations/{userId}')
  Future<SermonRecommendationResponse> getRecommendations(
    @Path('userId') int userId, {
    @Query('limit') int? limit,
    @Query('use_ai') bool? useAi,
    @Query('refresh') bool? refresh,
  });

  @POST('/api/v1/sermon-preferences/')
  Future<SermonPreferenceResponse> submitSermonPreference(
    @Body() SermonPreferenceRequest request,
  );

  @GET('/api/v1/church-recommendations/recommendations/{userId}')
  Future<ChurchRecommendationsResponse> getChurchRecommendations(
    @Path('userId') int userId, {
    @Query('limit') int? limit,
    @Query('use_ai') bool? useAi,
    @Query('refresh') bool? refresh,
  });

  @GET('/api/v1/churches/{church_id}')
  Future<ChurchModel> getChurch(@Path('church_id') int churchId);

  @GET('/api/v1/featured-sermons/churches/{church_id}/featured-sermons')
  Future<FeaturedSermonsResponse> getFeaturedSermons(
    @Path('church_id') int churchId,
  );
}
