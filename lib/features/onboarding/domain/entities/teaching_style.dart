import 'package:freezed_annotation/freezed_annotation.dart';

part 'teaching_style.freezed.dart';

@freezed
class TeachingStyle with _$TeachingStyle {
  const factory TeachingStyle({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isSelected,
  }) = _TeachingStyle;
}



