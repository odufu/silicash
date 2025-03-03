class AppConfig {
  static const String baseUrl = 'https://api.silicash.com'; // Replace with actual base URL
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // API Endpoints
  static const String loginEndpoint = '/auth/sign-in';
  static const String refreshTokenEndpoint = '/auth/refresh-token';
  
  // Storage Keys
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refreshToken';
  static const String userIdKey = 'userId';
  static const String emailKey = 'email';
  static const String phoneKey = 'phone';
  static const String fullNameKey = 'fullName';
  static const String firstNameKey = 'firstName';
  static const String expiresInKey = 'expiresIn';
  
  // Feature Flags
  static const bool enableBiometrics = true;
  static const bool enableDevicePreview = false;
}
