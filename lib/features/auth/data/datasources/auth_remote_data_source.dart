import 'package:test_for_orb_it/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Mocking network delay
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@example.com' && password == 'password') {
      return const UserModel(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://via.placeholder.com/150',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    return const UserModel(
      id: '2',
      email: 'google_user@gmail.com',
      name: 'Google User',
      photoUrl: 'https://via.placeholder.com/150',
    );
  }
}
