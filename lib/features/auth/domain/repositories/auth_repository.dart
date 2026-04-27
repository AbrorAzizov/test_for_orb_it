import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> loginWithGoogle();
  Future<void> logout();
  Future<String?> getToken();
  Future<bool> isAuthenticated();
}
