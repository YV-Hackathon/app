import 'package:freezed_annotation/freezed_annotation.dart';
import 'church_environment.dart';

part 'church_environment_state.freezed.dart';

@freezed
class ChurchEnvironmentState with _$ChurchEnvironmentState {
  const factory ChurchEnvironmentState({
    @Default([]) List<ChurchEnvironment> churchEnvironments,
    @Default(false) bool isLoading,
    String? error,
    String? selectedChurchEnvironmentId, // Only one can be selected
  }) = _ChurchEnvironmentState;
}



