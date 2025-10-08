import 'package:freezed_annotation/freezed_annotation.dart';

part 'personalization_intro.freezed.dart';

@freezed
class PersonalizationIntro with _$PersonalizationIntro {
  const factory PersonalizationIntro({
    required String id,
    required String title,
    required String description,
    required List<String> videoClips, // List of video clip URLs or asset paths
  }) = _PersonalizationIntro;
}



