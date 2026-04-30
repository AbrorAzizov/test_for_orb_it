import 'package:dartz/dartz.dart';
import 'package:test_for_orb_it/core/error/failures.dart';
import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<Either<Failure, void>, NoParams> {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}
