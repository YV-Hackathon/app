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
      // Index 0: speakers, 1: bible reading, 2: teaching style, 3: environment
      if (questionState.questions.length < 4) {
        throw Exception('Not all questions are loaded');
      }

      final bibleReadingQuestionId = questionState.questions[1].id;
      final teachingStyleQuestionId = questionState.questions[2].id;
      final environmentQuestionId = questionState.questions[3].id;

      print('📋 Question IDs:');
      print('  Bible: $bibleReadingQuestionId');
      print('  Teaching: $teachingStyleQuestionId');
      print('  Environment: $environmentQuestionId');

      // Get answers from questionState using actual question IDs
      final bibleReadingAnswer =
          questionState.selectedAnswers[bibleReadingQuestionId];
      final teachingStyleAnswer =
          questionState.selectedAnswers[teachingStyleQuestionId];
      final environmentAnswer =
          questionState.selectedAnswers[environmentQuestionId];

      print('📖 Bible Reading Answer: $bibleReadingAnswer');
      print('🎤 Teaching Style Answer: $teachingStyleAnswer');
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
      final environmentPref =
          environmentAnswer != null
              ? EnvironmentPreference.fromOptionValue(environmentAnswer)
              : null;

      print('🔄 Enum Conversion:');
      print('  Bible: "$bibleReadingAnswer" -> ${bibleReadingPref?.value}');
      print(
        '  Teaching: "$teachingStyleAnswer" -> ${teachingStylePref?.value}',
      );
      print('  Environment: "$environmentAnswer" -> ${environmentPref?.value}');

      // Validate all required fields are present
      if (bibleReadingPref == null ||
          teachingStylePref == null ||
          environmentPref == null) {
        print('❌ Validation Failed:');
        print('  bibleReadingPref is null: ${bibleReadingPref == null}');
        print('  teachingStylePref is null: ${teachingStylePref == null}');
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
          environmentPreference: environmentPref.value,
        ),
      );

      print('📤 Submitting request to API...');

      // Submit
      final useCase = ref.read(submitOnboardingUseCaseProvider);
      final response = await useCase(request);

      print('✅ Submission successful!');
      print('📦 Response: $response');
      print(
        '🎬 Recommended Sermons Count: ${response.recommendedSermons?.length ?? 0}',
      );

      if (response.recommendedSermons != null &&
          response.recommendedSermons!.isNotEmpty) {
        print('🎥 First sermon: ${response.recommendedSermons!.first.title}');
        print(
          '👤 Speaker: ${response.recommendedSermons!.first.speaker?.name ?? "Unknown"}',
        );
      } else {
        print('⚠️ WARNING: No recommended sermons in response!');
      }

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

  print('🔍 recommendedSermonsProvider called');
  print('   State status: ${submissionState.status}');
  print('   Response exists: ${submissionState.response != null}');
  print('   Sermons count: ${sermons.length}');

  return sermons;
}

/// Provider to check if recommended sermons are available
@Riverpod(keepAlive: true)
bool hasRecommendedSermons(Ref ref) {
  final sermons = ref.watch(recommendedSermonsProvider);
  return sermons.isNotEmpty;
}
