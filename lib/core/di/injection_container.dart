import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_for_orb_it/core/network/api_client.dart';
import 'package:test_for_orb_it/core/network/mock_api_client.dart';
import 'package:test_for_orb_it/features/auth/di/auth_module.dart';
import 'package:test_for_orb_it/features/home/di/home_module.dart';
import 'package:test_for_orb_it/features/settings/di/settings_module.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<ApiClient>(() => MockApiClient());

  initAuthModule();
  initHomeModule();
  initSettingsModule();
}
