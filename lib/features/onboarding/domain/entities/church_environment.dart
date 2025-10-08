import 'package:freezed_annotation/freezed_annotation.dart';

part 'church_environment.freezed.dart';

@freezed
class ChurchEnvironment with _$ChurchEnvironment {
  const factory ChurchEnvironment({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isSelected,
  }) = _ChurchEnvironment;
}



