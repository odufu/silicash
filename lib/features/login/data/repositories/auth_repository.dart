import 'package:dio/dio.dart';
import '../../../../core/repositories/repository_base.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/config/app_config.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository extends RepositoryBase {
  Future<ApiResult<LoginResponse>> login(LoginRequest request) async {
    final formData = FormData.fromMap({
      'email': request.email,
      'password': request.password,
    });

    return post<LoginResponse>(
      AppConfig.loginEndpoint,
      data: formData,
    );
  }

  Future<ApiResult<void>> logout() async {
    return post<void>(
      '/auth/logout',
    );
  }

  Future<ApiResult<LoginResponse>> refreshToken(String refreshToken) async {
    return post<LoginResponse>(
      AppConfig.refreshTokenEndpoint,
      data: {
        'refresh_token': refreshToken,
      },
    );
  }
}
