import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';

class LoginWithGoogleUseCase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;
  LoginWithGoogleUseCase(this.repository);

  @override
  Future<UserEntity?> call(NoParams params) {
    return repository.loginWithGoogle();
  }
}
