import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../network/api_client.dart';
import '../storage/secure_storage.dart';
import '../../features/authentication/provider/auth_provider.dart';
import '../../features/login/data/repositories/auth_repository.dart';
import '../../features/login/data/services/auth_service_impl.dart';
import '../../features/login/domain/services/login_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  sl.registerSingleton<SecureStorage>(SecureStorage());
  
  // Network
  sl.registerSingletonAsync<Dio>(() => DioClient.getInstance());
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(sl<Dio>()),
  );
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );

  // Services
  sl.registerLazySingleton<LoginService>(
    () => AuthServiceImpl(sl<AuthRepository>()),
  );

  // Providers
  sl.registerLazySingleton<AuthProvider>(
    () => AuthProvider(),
  );

  // Wait for async singletons
  await sl.allReady();
}

T inject<T extends Object>() => sl.get<T>();
