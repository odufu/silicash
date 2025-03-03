import 'package:flutter/foundation.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/di/injection.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = inject<SecureStorage>();
  bool _isLoggedIn = false;

  AuthProvider() {
    _init();
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<void> _init() async {
    final token = await _storage.read('token');
    _isLoggedIn = token != null;
    notifyListeners();
  }

  Future<void> login(String token) async {
    await _storage.write('token', token);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.delete('token');
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> refreshToken(String token) async {
    await _storage.write('token', token);
    _isLoggedIn = true;
    notifyListeners();
  }
}
