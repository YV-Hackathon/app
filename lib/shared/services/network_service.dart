import 'package:dio/dio.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/error/exceptions.dart';

class NetworkService {
  final Dio _dio;

  NetworkService(this._dio);

  factory NetworkService.create() {
    final dio = Dio();
    return NetworkService(dio);
  }

  Future<Map<String, dynamic>> healthCheck() async {
    try {
      final response = await _dio.get('${AppConstants.baseUrl}/health');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw NetworkException(message: 'Health check failed: $e');
    }
  }

  Future<Map<String, dynamic>> getUsers() async {
    try {
      final response = await _dio.get('${AppConstants.baseUrl}/users');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw NetworkException(message: 'Failed to get users: $e');
    }
  }

  Future<Map<String, dynamic>> getUser(String id) async {
    try {
      final response = await _dio.get('${AppConstants.baseUrl}/users/$id');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw NetworkException(message: 'Failed to get user: $e');
    }
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}/users',
        data: user,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw NetworkException(message: 'Failed to create user: $e');
    }
  }

  Future<Map<String, dynamic>> updateUser(
    String id,
    Map<String, dynamic> user,
  ) async {
    try {
      final response = await _dio.put(
        '${AppConstants.baseUrl}/users/$id',
        data: user,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw NetworkException(message: 'Failed to update user: $e');
    }
  }

  Future<Map<String, dynamic>> deleteUser(String id) async {
    try {
      final response = await _dio.delete('${AppConstants.baseUrl}/users/$id');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw NetworkException(message: 'Failed to delete user: $e');
    }
  }
}

class NetworkServiceFactory {
  static NetworkService create() {
    final dio = Dio();

    // Add interceptors for logging and error handling
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    return NetworkService(dio);
  }
}
