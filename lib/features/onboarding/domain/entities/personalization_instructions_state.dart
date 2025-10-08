import 'package:freezed_annotation/freezed_annotation.dart';
import 'personalization_instructions.dart';

part 'personalization_instructions_state.freezed.dart';

@freezed
class PersonalizationInstructionsState with _$PersonalizationInstructionsState {
  const factory PersonalizationInstructionsState({
    @Default([]) List<PersonalizationInstructions> personalizationInstructions,
    @Default(false) bool isLoading,
    String? error,
  }) = _PersonalizationInstructionsState;
}



