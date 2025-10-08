import 'package:freezed_annotation/freezed_annotation.dart';
import 'personalization_intro.dart';

part 'personalization_intro_state.freezed.dart';

@freezed
class PersonalizationIntroState with _$PersonalizationIntroState {
  const factory PersonalizationIntroState({
    @Default([]) List<PersonalizationIntro> personalizationIntros,
    @Default(false) bool isLoading,
    String? error,
  }) = _PersonalizationIntroState;
}



