import 'package:test_for_orb_it/core/di/injection_container.dart';
import 'package:test_for_orb_it/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:test_for_orb_it/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test_for_orb_it/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_for_orb_it/features/auth/domain/usecases/login_usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/usecases/logout_usecase.dart';
import 'package:test_for_orb_it/features/auth/presentation/bloc/auth_bloc.dart';

void initAuthModule() {
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      loginWithGoogleUseCase: sl(),
      logoutUseCase: sl(),
      repository: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
