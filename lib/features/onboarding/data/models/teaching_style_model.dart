import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/teaching_style.dart';

part 'teaching_style_model.freezed.dart';
part 'teaching_style_model.g.dart';

@freezed
class TeachingStyleModel with _$TeachingStyleModel {
  const factory TeachingStyleModel({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isSelected,
  }) = _TeachingStyleModel;

  factory TeachingStyleModel.fromJson(Map<String, dynamic> json) => _$TeachingStyleModelFromJson(json);
}

extension TeachingStyleModelX on TeachingStyleModel {
  TeachingStyle toEntity() {
    return TeachingStyle(
      id: id,
      title: title,
      description: description,
      isSelected: isSelected,
    );
  }
}



