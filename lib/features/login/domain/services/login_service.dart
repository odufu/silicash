import '../../../../core/network/api_result.dart';
import '../../data/models/login_response.dart';

abstract class LoginService {
  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  });

  Future<ApiResult<void>> logout();

  Future<ApiResult<LoginResponse>> refreshToken(String refreshToken);
}
