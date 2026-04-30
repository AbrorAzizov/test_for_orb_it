import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_for_orb_it/core/di/injection_container.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';
import 'route_paths.dart';

class RouteGuards {
  static FutureOr<String?> authGuard(BuildContext context, GoRouterState state) async {
    final authRepository = sl<AuthRepository>();
    final result = await authRepository.isAuthenticated();
    
    final bool isAuthenticated = result.fold((_) => false, (isAuth) => isAuth);
    final isLoggingIn = state.uri.path == RoutePaths.login;

    if (!isAuthenticated && !isLoggingIn) {
      return RoutePaths.login;
    }

    if (isAuthenticated && isLoggingIn) {
      return RoutePaths.home;
    }

    return null;
  }
}
