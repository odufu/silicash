import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'api_result.dart';
import 'network_exceptions.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<ApiResult<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResult.success(data: response.data as T);
    } on DioException catch (e) {
      return ApiResult.failure(error: NetworkExceptions.fromDioError(e));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.unexpectedError(e.toString()),
      );
    }
  }

  Future<ApiResult<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResult.success(data: response.data as T);
    } on DioException catch (e) {
      return ApiResult.failure(error: NetworkExceptions.fromDioError(e));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.unexpectedError(e.toString()),
      );
    }
  }

  Future<ApiResult<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResult.success(data: response.data as T);
    } on DioException catch (e) {
      return ApiResult.failure(error: NetworkExceptions.fromDioError(e));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.unexpectedError(e.toString()),
      );
    }
  }

  Future<ApiResult<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResult.success(data: response.data as T);
    } on DioException catch (e) {
      return ApiResult.failure(error: NetworkExceptions.fromDioError(e));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.unexpectedError(e.toString()),
      );
    }
  }
}
