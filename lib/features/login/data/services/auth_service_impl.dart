import '../../../../core/network/api_result.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../repositories/auth_repository.dart';
import '../../domain/services/login_service.dart';

class AuthServiceImpl implements LoginService {
  final AuthRepository _repository;

  AuthServiceImpl(this._repository);

  @override
  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(
      email: email,
      password: password,
    );
    
    return _repository.login(request);
  }

  @override
  Future<ApiResult<void>> logout() async {
    return _repository.logout();
  }

  @override
  Future<ApiResult<LoginResponse>> refreshToken(String refreshToken) async {
    return _repository.refreshToken(refreshToken);
  }
}
