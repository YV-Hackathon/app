import 'package:freezed_annotation/freezed_annotation.dart';

part 'sermon_preference_request.freezed.dart';
part 'sermon_preference_request.g.dart';

@freezed
class SermonPreferenceRequest with _$SermonPreferenceRequest {
  const factory SermonPreferenceRequest({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'sermon_id') required int sermonId,
    required String preference,
  }) = _SermonPreferenceRequest;

  factory SermonPreferenceRequest.fromJson(Map<String, dynamic> json) =>
      _$SermonPreferenceRequestFromJson(json);
}

enum SermonPreference {
  thumbsUp('thumbs_up'),
  thumbsDown('thumbs_down');

  final String value;
  const SermonPreference(this.value);
}
