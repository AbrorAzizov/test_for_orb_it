import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_for_orb_it/core/usecases/usecase.dart';
import 'package:test_for_orb_it/features/home/domain/usecases/get_businesses_usecase.dart';
import 'package:test_for_orb_it/features/home/domain/usecases/get_user_info_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserInfoUseCase getUserInfoUseCase;
  final GetBusinessesUseCase getBusinessesUseCase;

  HomeBloc({
    required this.getUserInfoUseCase,
    required this.getBusinessesUseCase,
  }) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    
    final userResult = await getUserInfoUseCase(NoParams());
    final businessesResult = await getBusinessesUseCase(NoParams());

    userResult.fold(
      (failure) => emit(HomeError(failure.message)),
      (user) {
        businessesResult.fold(
          (failure) => emit(HomeError(failure.message)),
          (businesses) => emit(HomeLoaded(user: user, businesses: businesses)),
        );
      },
    );
  }
}
