import 'package:test_for_orb_it/core/di/injection_container.dart';
import 'package:test_for_orb_it/features/home/data/datasources/home_remote_data_source.dart';
import 'package:test_for_orb_it/features/home/data/repositories/home_repository_impl.dart';
import 'package:test_for_orb_it/features/home/domain/repositories/home_repository.dart';
import 'package:test_for_orb_it/features/home/domain/usecases/get_businesses_usecase.dart';
import 'package:test_for_orb_it/features/home/domain/usecases/get_user_info_usecase.dart';
import 'package:test_for_orb_it/features/home/presentation/bloc/home_bloc.dart';

void initHomeModule() {
  // Bloc
  sl.registerFactory(
    () => HomeBloc(
      getUserInfoUseCase: sl(),
      getBusinessesUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetBusinessesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
}
