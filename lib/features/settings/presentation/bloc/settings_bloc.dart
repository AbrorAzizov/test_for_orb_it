import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/settings_local_data_source.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsLocalDataSource localDataSource;

  SettingsBloc({required this.localDataSource}) 
      : super(SettingsState(
          themeMode: localDataSource.getThemeMode(),
          locale: localDataSource.getLocale(),
        )) {
    on<ThemeChanged>((event, emit) async {
      await localDataSource.cacheThemeMode(event.themeMode);
      emit(state.copyWith(themeMode: event.themeMode));
    });
    on<LanguageChanged>((event, emit) async {
      await localDataSource.cacheLocale(event.locale);
      emit(state.copyWith(locale: event.locale));
    });
  }
}
