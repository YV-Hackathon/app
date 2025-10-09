import 'package:freezed_annotation/freezed_annotation.dart';

part 'sermon_preference_response.freezed.dart';
part 'sermon_preference_response.g.dart';

@freezed
class SermonPreferenceResponse with _$SermonPreferenceResponse {
  const factory SermonPreferenceResponse({
    String? message,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'sermon_id') int? sermonId,
    String? preference,
    Map<String, dynamic>? data,
  }) = _SermonPreferenceResponse;

  factory SermonPreferenceResponse.fromJson(Map<String, dynamic> json) =>
      _$SermonPreferenceResponseFromJson(json);
}
