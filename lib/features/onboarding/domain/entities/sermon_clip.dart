import 'package:freezed_annotation/freezed_annotation.dart';
import 'speaker.dart';

part 'sermon_clip.freezed.dart';
part 'sermon_clip.g.dart';

@freezed
class SermonClip with _$SermonClip {
  const factory SermonClip({
    required String id,
    required String title,
    required String videoUrl,
    required String thumbnailUrl,
    required String description,
    required Speaker speaker,
    required String churchName,
    required String churchLogo,
    required Duration duration,
    required Duration currentTime,
    required DateTime publishedAt,
    @Default(0) int viewCount,
    @Default(0) int likeCount,
    @Default([]) List<String> attributes,
    @Default(0) int matchingPreferences,
  }) = _SermonClip;

  factory SermonClip.fromJson(Map<String, dynamic> json) =>
      _$SermonClipFromJson(json);
}
