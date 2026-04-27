import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/home/data/datasources/home_remote_data_source.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';
import 'package:test_for_orb_it/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getUserInfo() async {
    return await remoteDataSource.getUserInfo();
  }

  @override
  Future<List<BusinessEntity>> getBusinesses() async {
    return await remoteDataSource.getBusinesses();
  }
}
