import 'package:dartz/dartz.dart';
import 'package:test_for_orb_it/core/error/failures.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, UserEntity>> getUserInfo();
  Future<Either<Failure, List<BusinessEntity>>> getBusinesses();
}
