import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements UseCase<UserEntity?, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<UserEntity?> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}
