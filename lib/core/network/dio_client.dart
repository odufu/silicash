import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../config/app_config.dart';
import '../storage/secure_storage.dart';

class DioClient {
  static Dio? _dio;

  static Future<Dio> getInstance() async {
    if (_dio == null) {
      _dio = await _createDioInstance();
    }
    return _dio!;
  }

  static Future<Dio> _createDioInstance() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      _AuthInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ),
    ]);

    return dio;
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.setToken(options);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid
      try {
        final refreshToken = await SecureStorage.getRefreshToken();
        if (refreshToken != null) {
          final dio = await DioClient.getInstance();
          final response = await dio.post(
            AppConfig.refreshTokenEndpoint,
            data: {'refresh_token': refreshToken},
          );

          if (response.statusCode == 200) {
            final newToken = response.data['token'];
            await SecureStorage.setToken(newToken);

            // Retry original request with new token
            final options = err.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';
            final retryResponse = await dio.fetch(options);
            return handler.resolve(retryResponse);
          }
        }
      } catch (e) {
        // Handle refresh token error
        // TODO: Implement logout or authentication error handling
      }
    }
    return handler.next(err);
  }
}
