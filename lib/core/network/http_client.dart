import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'api_result.dart';
import 'network_exceptions.dart';

class HttpClient {
  static Dio? _instance;

  static Future<Dio> getInstance() async {
    _instance ??= await _createDio();
    return _instance!;
  }

  static Future<Dio> _createDio() async {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      baseUrl: 'https://api.silicash.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    // Add interceptors
    dio.interceptors.addAll([
      _AuthInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
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
    final token = await TokenStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await TokenStorage.getRefreshToken();
        if (refreshToken != null) {
          final newToken = await _refreshToken(refreshToken);
          await TokenStorage.setToken(newToken);
          
          // Retry original request with new token
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newToken';
          final response = await Dio().fetch(opts);
          return handler.resolve(response);
        }
      } catch (e) {
        // Handle refresh token failure
        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: NetworkExceptions.unauthorizedRequest(),
          ),
        );
      }
    }
    handler.next(err);
  }

  Future<String> _refreshToken(String refreshToken) async {
    // Implement token refresh logic here
    throw UnimplementedError();
  }
}
