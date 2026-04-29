import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_for_orb_it/bootstrap.dart';
import 'package:test_for_orb_it/config/routes/app_routes.dart';
import 'package:test_for_orb_it/core/di/injection_container.dart' as di;
import 'package:test_for_orb_it/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_for_orb_it/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_for_orb_it/features/auth/presentation/bloc/auth_state.dart';
import 'package:test_for_orb_it/features/home/presentation/bloc/home_bloc.dart';
import 'package:test_for_orb_it/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:test_for_orb_it/features/settings/presentation/bloc/settings_state.dart';

import 'l10n/app_localizations.dart';

void main() async {
  await bootstrap(() => const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(AppStarted()),
        ),
        BlocProvider(
          create: (_) => di.sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<SettingsBloc>(),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, authState) {
              if (authState is Unauthenticated) {
                router.go('/login');
              }
            },
            child: MaterialApp.router(
              title: 'Orb-it Test',
              themeMode: settingsState.themeMode,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue,
                  brightness: Brightness.dark,
                ),
              ),
              locale: settingsState.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: router,
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
