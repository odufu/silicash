import 'package:dio/dio.dart';
import '../../../../core/repositories/repository_base.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/config/app_config.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class LoginRepository extends RepositoryBase {
  Future<ApiResult<LoginResponse>> login(LoginRequest request) async {
    return post<LoginResponse>(
      AppConfig.loginEndpoint,
      data: FormData.fromMap(request.toJson()),
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
