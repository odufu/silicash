import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/api_result.dart';
import '../di/injection.dart';

abstract class RepositoryBase {
  final ApiClient _apiClient = inject<ApiClient>();

  Future<ApiResult<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _apiClient.get<T>(
      endpoint,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<ApiResult<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _apiClient.post<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<ApiResult<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _apiClient.put<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<ApiResult<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _apiClient.delete<T>(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}

abstract class RepositoryInterface<T> {
  Future<ApiResult<T>> get(String endpoint, {Map<String, dynamic>? params});
  Future<ApiResult<T>> post(String endpoint, {dynamic data});
  Future<ApiResult<T>> put(String endpoint, {dynamic data});
  Future<ApiResult<T>> delete(String endpoint);
}
