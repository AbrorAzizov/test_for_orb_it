import 'package:dartz/dartz.dart';
import 'package:test_for_orb_it/core/error/failures.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String?>> getToken();
  Future<Either<Failure, bool>> isAuthenticated();
}
