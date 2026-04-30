import 'package:test_for_orb_it/core/network/api_client.dart';
import 'package:test_for_orb_it/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> loginWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.post('/login', data: {'email': email, 'password': password});
    
    if (response.statusCode == 200 && response.data != null) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final response = await apiClient.post('/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    
    if (response.statusCode == 200 && response.data != null) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Registration failed');
    }
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    final response = await apiClient.post('/login/google');
    return UserModel.fromJson(response.data);
  }
}
