import 'package:test_for_orb_it/core/network/api_client.dart';
import 'package:test_for_orb_it/features/auth/data/models/user_model.dart';
import 'package:test_for_orb_it/features/home/data/models/business_model.dart';

abstract class HomeRemoteDataSource {
  Future<UserModel> getUserInfo();
  Future<List<BusinessModel>> getBusinesses();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> getUserInfo() async {
    final response = await apiClient.get('/user/me');
    return UserModel.fromJson(response.data);
  }

  @override
  Future<List<BusinessModel>> getBusinesses() async {
    final response = await apiClient.get('/businesses');
    final List<dynamic> data = response.data;
    return data.map((json) => BusinessModel.fromJson(json)).toList();
  }
}
