import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/loading_screen.dart';

part 'loading_screen_model.freezed.dart';
part 'loading_screen_model.g.dart';

@freezed
class LoadingScreenModel with _$LoadingScreenModel {
  const factory LoadingScreenModel({
    required String id,
    required String title,
    required String description,
    required String buttonText,
    required int progressSteps,
    required int currentStep,
  }) = _LoadingScreenModel;

  factory LoadingScreenModel.fromJson(Map<String, dynamic> json) =>
      _$LoadingScreenModelFromJson(json);
}

extension LoadingScreenModelX on LoadingScreenModel {
  LoadingScreen toEntity() {
    return LoadingScreen(
      id: id,
      title: title,
      description: description,
      buttonText: buttonText,
      progressSteps: progressSteps,
      currentStep: currentStep,
    );
  }
}



