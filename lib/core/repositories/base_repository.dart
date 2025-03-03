import 'package:dio/dio.dart';
import '../network/api_result.dart';
import '../network/network_exceptions.dart';

abstract class BaseRepository {
  Future<ApiResult<T>> handleApiCall<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return ApiResult.success(data: response);
    } on DioException catch (e) {
      return ApiResult.failure(error: NetworkExceptions.fromDioError(e));
    } catch (e) {
      return ApiResult.failure(
        error: NetworkExceptions.unexpectedError(e.toString()),
      );
    }
  }
}

abstract class BaseRepositoryInterface<T> {
  Future<ApiResult<T>> get(String endpoint, {Map<String, dynamic>? params});
  Future<ApiResult<T>> post(String endpoint, {dynamic data});
  Future<ApiResult<T>> put(String endpoint, {dynamic data});
  Future<ApiResult<T>> delete(String endpoint);
}
