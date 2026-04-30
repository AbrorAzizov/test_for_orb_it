import 'package:dartz/dartz.dart';
import 'package:test_for_orb_it/core/error/failures.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/home/data/datasources/home_remote_data_source.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';
import 'package:test_for_orb_it/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async {
    try {
      final user = await remoteDataSource.getUserInfo();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BusinessEntity>>> getBusinesses() async {
    try {
      final businesses = await remoteDataSource.getBusinesses();
      return Right(businesses);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
