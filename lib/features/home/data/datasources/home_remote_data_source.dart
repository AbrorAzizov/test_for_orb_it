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
    await apiClient.get('/user/me');
    return const UserModel(
      id: '1',
      email: 'test@example.com',
      name: 'John Doe',
      photoUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=John',
    );
  }

  @override
  Future<List<BusinessModel>> getBusinesses() async {
    await apiClient.get('/businesses');
    return [
      const BusinessModel(
        id: 'b1',
        name: 'Coffee Shop',
        description: 'Best coffee in town',
        imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
      ),
      const BusinessModel(
        id: 'b2',
        name: 'Tech Solutions',
        description: 'Software development services',
        imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
      ),
    ];
  }
}
