import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_destinations_usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_offers_usecase.dart';
import 'package:elysian_user/features/home/domain/usecases/get_user_points_usecase.dart';
import 'package:elysian_user/features/home/logic/bloc/home/home_event.dart';
import 'package:elysian_user/features/home/logic/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetDestinationsUseCase getDestinationsUseCase;
  final GetOffersUseCase getOffersUseCase;
  final GetUserPointsUseCase getUserPointsUseCase;

  HomeBloc({
    required this.getCategoriesUseCase,
    required this.getDestinationsUseCase,
    required this.getOffersUseCase,
    required this.getUserPointsUseCase,
  }) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final categoriesResult = await getCategoriesUseCase(NoParams());
    final destinationsResult = await getDestinationsUseCase(NoParams());
    final offersResult = await getOffersUseCase(NoParams());
    final pointsResult = await getUserPointsUseCase(NoParams());

    categoriesResult.fold((failure) => emit(HomeError(failure.message)), (
      categories,
    ) {
      destinationsResult.fold((failure) => emit(HomeError(failure.message)), (
        destinations,
      ) {
        offersResult.fold((failure) => emit(HomeError(failure.message)), (
          offers,
        ) {
          pointsResult.fold((failure) => emit(HomeError(failure.message)), (
            points,
          ) {
            emit(
              HomeLoaded(
                categories: categories,
                destinations: destinations,
                offers: offers,
                userPoints: points,
              ),
            );
          });
        });
      });
    });
  }
}
