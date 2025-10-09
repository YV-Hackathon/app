import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/speaker.dart';
import 'question_provider.dart';

part 'specific_question_providers.g.dart';

/// Provider for speakers question (index 0)
/// Converts QuestionOptions to Speaker entities
@riverpod
List<Speaker> speakers(Ref ref) {
  final questionState = ref.watch(questionNotifierProvider);

  if (questionState.questions.isEmpty) return [];

  final speakersQuestion = questionState.questions[0];

  // Convert QuestionOptions to Speaker entities
  return speakersQuestion.options.map((option) {
    return Speaker(
      id: option.id,
      name: option.title,
      // Use profile picture URL from API, fallback to local asset
      imageUrl: option.imageUrl ?? 'assets/speakers/${option.id}.png',
      isSelected: option.isSelected,
    );
  }).toList();
}

/// Provider for selected speakers
@riverpod
List<String> selectedSpeakers(Ref ref) {
  final speakers = ref.watch(speakersProvider);
  return speakers.where((s) => s.isSelected).map((s) => s.id).toList();
}

/// Provider for bible reading preference question (index 1)
@riverpod
Question? bibleReadingQuestion(Ref ref) {
  final questionState = ref.watch(questionNotifierProvider);

  if (questionState.questions.length < 2) return null;

  return questionState.questions[1];
}

/// Provider for teaching style preference question (index 2)
@riverpod
Question? teachingStyleQuestion(Ref ref) {
  final questionState = ref.watch(questionNotifierProvider);

  if (questionState.questions.length < 3) return null;

  return questionState.questions[2];
}

/// Provider for environment preference question (index 3)
@riverpod
Question? environmentQuestion(Ref ref) {
  final questionState = ref.watch(questionNotifierProvider);

  if (questionState.questions.length < 4) return null;

  return questionState.questions[3];
}

/// Provider for checking if questions are loading
@riverpod
bool questionsLoading(Ref ref) {
  return ref.watch(questionNotifierProvider).isLoading;
}

/// Provider for questions error
@riverpod
String? questionsError(Ref ref) {
  return ref.watch(questionNotifierProvider).error;
}
