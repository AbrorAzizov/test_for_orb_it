import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/auth/domain/entities/user_entity.dart';
import 'package:test_for_orb_it/features/home/domain/repositories/home_repository.dart';

class GetUserInfoUseCase implements UseCase<UserEntity, NoParams> {
  final HomeRepository repository;
  GetUserInfoUseCase(this.repository);

  @override
  Future<UserEntity> call(NoParams params) {
    return repository.getUserInfo();
  }
}
