import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../network/api_client.dart';
import '../storage/secure_storage.dart';
import '../../features/authentication/provider/auth_provider.dart';
import '../../features/login/data/repositories/login_repository.dart';
import '../../features/login/data/services/login_service_impl.dart';
import '../../features/login/domain/services/login_service.dart';
import '../config/app_config.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  sl.registerSingleton<SecureStorage>(SecureStorage());
  
  // Network
  sl.registerSingletonAsync<Dio>(() => DioClient.getInstance());
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(sl<Dio>()),
  );
  
  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepository(),
  );

  // Services
  sl.registerLazySingleton<LoginService>(
    () => LoginServiceImpl(sl<LoginRepository>()),
  );

  // Providers
  sl.registerLazySingleton<AuthProvider>(
    () => AuthProvider(),
  );

  // Wait for async singletons
  await sl.allReady();
}

// Helper function to reset dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
}

// Helper function to get a registered instance
T inject<T extends Object>() => sl.get<T>();
