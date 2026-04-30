import 'package:test_for_orb_it/core/di/injection_container.dart';
import 'package:test_for_orb_it/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:test_for_orb_it/features/settings/presentation/bloc/settings_bloc.dart';

void initSettingsModule() {
  // Bloc
  sl.registerFactory(() => SettingsBloc(localDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
