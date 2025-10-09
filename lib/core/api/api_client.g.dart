// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<List<QuestionModel>> getOnboardingQuestions() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<QuestionModel>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/onboarding/questions',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<QuestionModel> _value;
    try {
      _value =
          _result.data!
              .map(
                (dynamic i) =>
                    QuestionModel.fromJson(i as Map<String, dynamic>),
              )
              .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<OnboardingSubmissionResponse> submitOnboarding(
    OnboardingSubmissionRequest request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = request;
    final _options = _setStreamType<OnboardingSubmissionResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/onboarding/submit',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);

    // Debug: Print raw response data
    print('🔍 RAW SUBMISSION RESPONSE: ${_result.data}');
    print('🔍 Response status: ${_result.statusCode}');
    print('🔍 Response data type: ${_result.data.runtimeType}');
    if (_result.data != null &&
        _result.data!.containsKey('recommended_sermons')) {
      print(
        '🎬 recommended_sermons field exists: ${_result.data!['recommended_sermons']}',
      );
      print(
        '🎬 recommended_sermons type: ${_result.data!['recommended_sermons'].runtimeType}',
      );
      if (_result.data!['recommended_sermons'] is List) {
        print(
          '🎬 recommended_sermons length: ${(_result.data!['recommended_sermons'] as List).length}',
        );
      }
    } else {
      print('⚠️ WARNING: recommended_sermons field NOT found in response!');
      print('Available keys: ${_result.data?.keys.toList()}');
    }

    late OnboardingSubmissionResponse _value;
    try {
      _value = OnboardingSubmissionResponse.fromJson(_result.data!);
      print('✅ Parsed OnboardingSubmissionResponse successfully');
      print(
        '🎬 Parsed recommendedSermons count: ${_value.recommendedSermons?.length ?? 0}',
      );
    } on Object catch (e, s) {
      print('❌ ERROR parsing OnboardingSubmissionResponse: $e');
      print('❌ Stack trace: $s');
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<SermonRecommendationResponse> getRecommendations(
    int userId, {
    int? limit,
    bool? useAi,
    bool? refresh,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'use_ai': useAi,
      r'refresh': refresh,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<SermonRecommendationResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/sermons/recommendations/${userId}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SermonRecommendationResponse _value;
    try {
      _value = SermonRecommendationResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<SermonPreferenceResponse> submitSermonPreference(
    SermonPreferenceRequest request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = request;
    final _options = _setStreamType<SermonPreferenceResponse>(
      Options(method: 'POST', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/sermon-preferences/',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SermonPreferenceResponse _value;
    try {
      _value = SermonPreferenceResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
