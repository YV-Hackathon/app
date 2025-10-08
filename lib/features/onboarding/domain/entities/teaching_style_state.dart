import 'package:freezed_annotation/freezed_annotation.dart';
import 'teaching_style.dart';

part 'teaching_style_state.freezed.dart';

@freezed
class TeachingStyleState with _$TeachingStyleState {
  const factory TeachingStyleState({
    @Default([]) List<TeachingStyle> teachingStyles,
    @Default(false) bool isLoading,
    String? error,
    String? selectedTeachingStyleId, // Only one can be selected
  }) = _TeachingStyleState;
}



