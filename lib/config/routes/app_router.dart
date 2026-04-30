import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_for_orb_it/core/di/injection_container.dart';
import 'package:test_for_orb_it/features/auth/presentation/pages/login_page.dart';
import 'package:test_for_orb_it/features/auth/presentation/pages/register_page.dart';
import 'package:test_for_orb_it/features/home/presentation/bloc/home_bloc.dart';
import 'package:test_for_orb_it/features/home/presentation/pages/home_page.dart';
import 'package:test_for_orb_it/features/settings/presentation/pages/settings_page.dart';
import 'route_paths.dart';
import 'route_names.dart';

final class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter? _cachedRouter;
  static bool? _lastIsAuthenticated;

  static GoRouter createRouter({required bool isAuthenticated}) {
    if (_cachedRouter != null && _lastIsAuthenticated == isAuthenticated) {
      return _cachedRouter!;
    }

    _lastIsAuthenticated = isAuthenticated;

    _cachedRouter = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: isAuthenticated ? RoutePaths.home : RoutePaths.login,
      redirect: (context, state) {
        final isLoggingIn = state.uri.path == RoutePaths.login;
        final isRegistering = state.uri.path == RoutePaths.register;
        
        if (!isAuthenticated && !isLoggingIn && !isRegistering) return RoutePaths.login;
        if (isAuthenticated && (isLoggingIn || isRegistering)) return RoutePaths.home;
        return null;
      },
      routes: _routes,
    );

    return _cachedRouter!;
  }

  static final List<RouteBase> _routes = [
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      builder: (context, state) => const RegisterPage(),
    ),
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => sl<HomeBloc>(),
          child: MainShell(child: child),
        );
      },
      routes: [
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: RoutePaths.settings,
          name: RouteNames.settings,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ];

  static GoRouter get router {
    if (_cachedRouter == null) throw Exception('Router not initialized');
    return _cachedRouter!;
  }

  static void goNamed(String name) => router.goNamed(name);
}

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    int currentIndex = location == RoutePaths.home ? 0 : 1;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            context.go(RoutePaths.home);
          } else {
            context.go(RoutePaths.settings);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
