import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/church_environment.dart';

part 'church_environment_model.freezed.dart';
part 'church_environment_model.g.dart';

@freezed
class ChurchEnvironmentModel with _$ChurchEnvironmentModel {
  const factory ChurchEnvironmentModel({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isSelected,
  }) = _ChurchEnvironmentModel;

  factory ChurchEnvironmentModel.fromJson(Map<String, dynamic> json) =>
      _$ChurchEnvironmentModelFromJson(json);
}

extension ChurchEnvironmentModelX on ChurchEnvironmentModel {
  ChurchEnvironment toEntity() {
    return ChurchEnvironment(
      id: id,
      title: title,
      description: description,
      isSelected: isSelected,
    );
  }
}



