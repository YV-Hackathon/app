import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_screen.freezed.dart';

@freezed
class LoadingScreen with _$LoadingScreen {
  const factory LoadingScreen({
    required String id,
    required String title,
    required String description,
    required String buttonText,
    required int progressSteps,
    required int currentStep,
  }) = _LoadingScreen;
}



