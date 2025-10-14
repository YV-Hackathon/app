import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../api/api_client.dart';
import '../constants/app_constants.dart';

part 'api_providers.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  print('🔧 Configuring Dio with baseUrl: ${AppConstants.baseUrl}');

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      sendTimeout: AppConstants.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Allow self-signed certificates in development
  // WARNING: Do NOT use this in production!
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      print('⚠️ Accepting certificate from $host:$port');
      return true; // Accept all certificates
    };
    return client;
  };

  print('✅ Dio configured. Base URL: ${dio.options.baseUrl}');
  print('📋 Headers: ${dio.options.headers}');
  print('⏱️ Timeout: ${dio.options.connectTimeout}');
  print('🔓 SSL certificate verification disabled for development');

  // Add interceptors for logging and error handling
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
    ),
  );

  return dio;
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
}
