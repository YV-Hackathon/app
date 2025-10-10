import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/global_providers/api_providers.dart';
import '../../data/models/onboarding_submission_request.dart';
import '../../data/models/onboarding_submission_response.dart';
import '../../data/repositories/onboarding_submission_repository_impl.dart';
import '../../domain/entities/preference_enums.dart';
import '../../domain/repositories/onboarding_submission_repository.dart';
import '../../domain/usecases/submit_onboarding_usecase.dart';
import 'question_provider.dart';

part 'onboarding_submission_provider.g.dart';

/// Repository Provider
@Riverpod(keepAlive: true)
OnboardingSubmissionRepository onboardingSubmissionRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OnboardingSubmissionRepositoryImpl(apiClient);
}

/// Use Case Provider
@Riverpod(keepAlive: true)
SubmitOnboardingUseCase submitOnboardingUseCase(Ref ref) {
  final repository = ref.watch(onboardingSubmissionRepositoryProvider);
  return SubmitOnboardingUseCaseImpl(repository);
}

/// Submission State
enum SubmissionStatus { idle, submitting, success, error }

class OnboardingSubmissionState {
  final SubmissionStatus status;
  final OnboardingSubmissionResponse? response;
  final String? error;

  const OnboardingSubmissionState({
    this.status = SubmissionStatus.idle,
    this.response,
    this.error,
  });

  OnboardingSubmissionState copyWith({
    SubmissionStatus? status,
    OnboardingSubmissionResponse? response,
    String? error,
  }) {
    return OnboardingSubmissionState(
      status: status ?? this.status,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}

/// Submission Notifier
@Riverpod(keepAlive: true)
class OnboardingSubmissionNotifier extends _$OnboardingSubmissionNotifier {
  @override
  OnboardingSubmissionState build() {
    return const OnboardingSubmissionState();
  }

  Future<void> submitOnboarding() async {
    // Get question state to build submission
    final questionState = ref.read(questionNotifierProvider);

    try {
      print('🔍 Starting onboarding submission...');
      print('📊 Question State: ${questionState.questions.length} questions');
      print('✅ Selected Answers: ${questionState.selectedAnswers}');

      state = state.copyWith(status: SubmissionStatus.submitting);

      // Get selected speakers (convert string IDs to int)
      final selectedSpeakerIds =
          ref
              .read(questionNotifierProvider.notifier)
              .getSelectedSpeakers()
              .map((id) => int.tryParse(id) ?? 0)
              .toList();

      print('👥 Selected Speaker IDs: $selectedSpeakerIds');

      // Get question IDs from actual questions (by index)
      // Index 0: bible reading, 1: teaching style, 2: gender, 3: environment, 4: speakers
      if (questionState.questions.length < 5) {
        throw Exception('Not all questions are loaded');
      }

      final bibleReadingQuestionId = questionState.questions[0].id;
      final teachingStyleQuestionId = questionState.questions[1].id;
      final genderQuestionId = questionState.questions[2].id;
      final environmentQuestionId = questionState.questions[3].id;

      print('📋 Question IDs:');
      print('  Bible: $bibleReadingQuestionId');
      print('  Teaching: $teachingStyleQuestionId');
      print('  Gender: $genderQuestionId');
      print('  Environment: $environmentQuestionId');

      // Get answers from questionState using actual question IDs
      final bibleReadingAnswer =
          questionState.selectedAnswers[bibleReadingQuestionId];
      final teachingStyleAnswer =
          questionState.selectedAnswers[teachingStyleQuestionId];
      final genderAnswer = questionState.selectedAnswers[genderQuestionId];
      final environmentAnswer =
          questionState.selectedAnswers[environmentQuestionId];

      print('📖 Bible Reading Answer: $bibleReadingAnswer');
      print('🎤 Teaching Style Answer: $teachingStyleAnswer');
      print('👤 Gender Answer: $genderAnswer');
      print('⛪ Environment Answer: $environmentAnswer');

      // Map to enums
      final bibleReadingPref =
          bibleReadingAnswer != null
              ? BibleReadingPreference.fromOptionValue(bibleReadingAnswer)
              : null;
      final teachingStylePref =
          teachingStyleAnswer != null
              ? TeachingStylePreference.fromOptionValue(teachingStyleAnswer)
              : null;
      final genderPref =
          genderAnswer != null
              ? GenderPreference.fromOptionValue(genderAnswer)
              : null;
      final environmentPref =
          environmentAnswer != null
              ? EnvironmentPreference.fromOptionValue(environmentAnswer)
              : null;

      print('🔄 Enum Conversion:');
      print('  Bible: "$bibleReadingAnswer" -> ${bibleReadingPref?.value}');
      print(
        '  Teaching: "$teachingStyleAnswer" -> ${teachingStylePref?.value}',
      );
      print('  Gender: "$genderAnswer" -> ${genderPref?.value}');
      print('  Environment: "$environmentAnswer" -> ${environmentPref?.value}');

      // Validate all required fields are present
      if (bibleReadingPref == null ||
          teachingStylePref == null ||
          genderPref == null ||
          environmentPref == null) {
        print('❌ Validation Failed:');
        print('  bibleReadingPref is null: ${bibleReadingPref == null}');
        print('  teachingStylePref is null: ${teachingStylePref == null}');
        print('  genderPref is null: ${genderPref == null}');
        print('  environmentPref is null: ${environmentPref == null}');
        throw Exception('Missing required onboarding answers');
      }

      // Build request
      final request = OnboardingSubmissionRequest(
        userId: 6,
        answers: OnboardingAnswers(
          speakers: selectedSpeakerIds,
          bibleReadingPreference: bibleReadingPref.value,
          teachingStylePreference: teachingStylePref.value,
          genderPreference: genderPref.value,
          environmentPreference: environmentPref.value,
        ),
      );

      print('📤 ==================== SUBMITTING REQUEST ====================');
      print('📤 Request JSON:');
      print(request.toJson());
      print('📤 Full Request Details:');
      print('   User ID: 6');
      print(
        '   Speakers: $selectedSpeakerIds (${selectedSpeakerIds.length} selected)',
      );
      print('   Bible Reading: ${bibleReadingPref.value}');
      print('   Teaching Style: ${teachingStylePref.value}');
      print('   Gender Preference: ${genderPref.value}');
      print('   Environment: ${environmentPref.value}');
      print('📤 ============================================================');

      // Submit
      final useCase = ref.read(submitOnboardingUseCaseProvider);
      final response = await useCase(request);

      print('✅ ==================== RESPONSE RECEIVED ====================');
      print('📦 Full Response: $response');
      print(
        '🎬 Recommended Sermons Count: ${response.recommendedSermons?.length ?? 0}',
      );

      if (response.recommendedSermons != null) {
        print('📺 All Recommended Sermons:');
        for (var i = 0; i < response.recommendedSermons!.length; i++) {
          final sermon = response.recommendedSermons![i];
          print('   [$i] ${sermon.title}');
          print('       Speaker: ${sermon.speaker?.name ?? "Unknown"}');
          print('       ID: ${sermon.id}');
          print('       GCS URL: ${sermon.gcsUrl}');
          print('       Description: ${sermon.description}');
          print('       Is Clip: ${sermon.isClip ?? false}');
        }
      } else {
        print('⚠️ WARNING: recommendedSermons is NULL in response!');
      }
      print('✅ ============================================================');

      state = state.copyWith(
        status: SubmissionStatus.success,
        response: response,
      );

      print('💾 State updated with response. Status: ${state.status}');
    } catch (e, stackTrace) {
      print('❌ Submission Error: $e');
      print('📍 Stack trace: $stackTrace');
      state = state.copyWith(
        status: SubmissionStatus.error,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = const OnboardingSubmissionState();
  }
}

/// Provider to access recommended sermons from the submission response
@Riverpod(keepAlive: true)
List<RecommendedSermon> recommendedSermons(Ref ref) {
  final submissionState = ref.watch(onboardingSubmissionNotifierProvider);
  final sermons = submissionState.response?.recommendedSermons ?? [];

  print(
    '🔍 ==================== RECOMMENDED SERMONS PROVIDER ====================',
  );
  print('   State status: ${submissionState.status}');
  print('   Response exists: ${submissionState.response != null}');
  if (submissionState.response != null) {
    print(
      '   Response.recommendedSermons exists: ${submissionState.response!.recommendedSermons != null}',
    );
    if (submissionState.response!.recommendedSermons != null) {
      print(
        '   Response.recommendedSermons length: ${submissionState.response!.recommendedSermons!.length}',
      );
      print(
        '   Response.recommendedSermons raw data: ${submissionState.response!.recommendedSermons}',
      );
    }
  }
  print('   Final sermons count to return: ${sermons.length}');
  if (sermons.isEmpty) {
    print('   ⚠️ Returning EMPTY list!');
  }
  print('🔍 ================================================================');

  return sermons;
}

/// Provider to check if recommended sermons are available
@Riverpod(keepAlive: true)
bool hasRecommendedSermons(Ref ref) {
  final sermons = ref.watch(recommendedSermonsProvider);
  return sermons.isNotEmpty;
}
