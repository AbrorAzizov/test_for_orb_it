import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_for_orb_it/features/auth/domain/usecases/login_usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository repository;

  AuthBloc({
    required this.loginUseCase,
    required this.loginWithGoogleUseCase,
    required this.logoutUseCase,
    required this.repository,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final isAuthenticated = await repository.isAuthenticated();
    if (isAuthenticated) {
      // Mocking user fetch from saved token
      emit(const Authenticated(UserEntity(
        id: '1',
        email: 'test@example.com',
        name: 'John Doe',
        photoUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=John',
      )));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(LoginParams(email: event.email, password: event.password));
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGoogleLoginRequested(GoogleLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginWithGoogleUseCase(NoParams());
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const AuthError('Google login failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    await logoutUseCase(NoParams());
    emit(Unauthenticated());
  }
}
