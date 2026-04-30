import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_for_orb_it/core/usecases/usecase.dart';
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
    final result = await repository.isAuthenticated();
    result.fold(
      (failure) => emit(Unauthenticated()),
      (isAuthenticated) {
        if (isAuthenticated) {
          // In a real app, we would fetch the user profile here.
          // For now, emit unauthenticated to show login screen as per prev logic
          emit(Unauthenticated()); 
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(LoginParams(email: event.email, password: event.password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onGoogleLoginRequested(GoogleLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginWithGoogleUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    final result = await logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }
}
