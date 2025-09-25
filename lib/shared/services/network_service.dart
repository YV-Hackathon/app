import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/error/exceptions.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class NetworkService {
  factory NetworkService(Dio dio, {String baseUrl}) = _NetworkService;

  @GET('/health')
  Future<Map<String, dynamic>> healthCheck();

  @GET('/users')
  Future<Map<String, dynamic>> getUsers();

  @GET('/users/{id}')
  Future<Map<String, dynamic>> getUser(@Path('id') String id);

  @POST('/users')
  Future<Map<String, dynamic>> createUser(@Body() Map<String, dynamic> user);

  @PUT('/users/{id}')
  Future<Map<String, dynamic>> updateUser(
    @Path('id') String id,
    @Body() Map<String, dynamic> user,
  );

  @DELETE('/users/{id}')
  Future<Map<String, dynamic>> deleteUser(@Path('id') String id);
}

class NetworkServiceFactory {
  static NetworkService create() {
    final dio = Dio();

    // Configure interceptors
    dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);

    // Configure options
    dio.options = BaseOptions(
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      sendTimeout: AppConstants.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    return NetworkService(dio);
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add authentication token if available
    // final token = getTokenFromStorage();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    handler.next(options);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(
              message:
                  'Connection timeout. Please check your internet connection.',
            ),
          ),
        );
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode != null) {
          if (statusCode >= 400 && statusCode < 500) {
            handler.next(
              DioException(
                requestOptions: err.requestOptions,
                error: ServerException(
                  message: err.response?.data?['message'] ?? 'Client error',
                  code: statusCode.toString(),
                ),
              ),
            );
          } else if (statusCode >= 500) {
            handler.next(
              DioException(
                requestOptions: err.requestOptions,
                error: const ServerException(
                  message: 'Server error. Please try again later.',
                ),
              ),
            );
          }
        }
        break;
      case DioExceptionType.cancel:
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(message: 'Request was cancelled'),
          ),
        );
        break;
      case DioExceptionType.connectionError:
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: const NetworkException(
              message: 'No internet connection. Please check your network.',
            ),
          ),
        );
        break;
      default:
        handler.next(
          DioException(
            requestOptions: err.requestOptions,
            error: const UnknownException(message: 'An unknown error occurred'),
          ),
        );
    }
  }
}
