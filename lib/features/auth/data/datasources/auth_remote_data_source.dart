import 'package:test_for_orb_it/core/network/api_client.dart';
import 'package:test_for_orb_it/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> loginWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login(String email, String password) async {
    await apiClient.post('/login', data: {'email': email, 'password': password});
    
    if (email == 'test@example.com' && password == 'password') {
      return const UserModel(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Test',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    await apiClient.post('/login/google');
    return const UserModel(
      id: '2',
      email: 'google_user@gmail.com',
      name: 'Google User',
      photoUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Google',
    );
  }
}
