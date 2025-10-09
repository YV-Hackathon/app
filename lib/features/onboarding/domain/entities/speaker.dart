import 'package:freezed_annotation/freezed_annotation.dart';

part 'speaker.freezed.dart';
part 'speaker.g.dart';

@freezed
class Speaker with _$Speaker {
  const factory Speaker({
    required String id,
    required String name,
    required String imageUrl,
    @Default(false) bool isSelected,
  }) = _Speaker;

  factory Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);
}
