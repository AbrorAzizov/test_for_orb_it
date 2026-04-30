import 'package:dartz/dartz.dart';
import 'package:test_for_orb_it/core/error/failures.dart';
import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';
import 'package:test_for_orb_it/features/home/domain/repositories/home_repository.dart';

class GetBusinessesUseCase implements UseCase<Either<Failure, List<BusinessEntity>>, NoParams> {
  final HomeRepository repository;
  GetBusinessesUseCase(this.repository);

  @override
  Future<Either<Failure, List<BusinessEntity>>> call(NoParams params) {
    return repository.getBusinesses();
  }
}
