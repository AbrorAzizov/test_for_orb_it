import 'package:test_for_orb_it/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:test_for_orb_it/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity?> login(String email, String password) async {
    final user = await remoteDataSource.login(email, password);
    await localDataSource.saveToken('mock_token_${user.id}');
    return user;
  }

  @override
  Future<UserEntity?> loginWithGoogle() async {
    final user = await remoteDataSource.loginWithGoogle();
    await localDataSource.saveToken('mock_token_${user.id}');
    return user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteToken();
  }

  @override
  Future<String?> getToken() async {
    return await localDataSource.getToken();
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await localDataSource.getToken();
    return token != null;
  }
}
