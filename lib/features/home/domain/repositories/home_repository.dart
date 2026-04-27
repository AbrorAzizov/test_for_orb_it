import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';

abstract class HomeRepository {
  Future<UserEntity> getUserInfo();
  Future<List<BusinessEntity>> getBusinesses();
}
