import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/home/domain/entities/business_entity.dart';
import 'package:test_for_orb_it/features/home/domain/repositories/home_repository.dart';

class GetBusinessesUseCase implements UseCase<List<BusinessEntity>, NoParams> {
  final HomeRepository repository;
  GetBusinessesUseCase(this.repository);

  @override
  Future<List<BusinessEntity>> call(NoParams params) {
    return repository.getBusinesses();
  }
}
