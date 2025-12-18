import 'package:elysian_user/features/home/domain/entities/category_entity.dart';
import 'package:elysian_user/features/home/domain/entities/destination_entity.dart';
import 'package:elysian_user/features/home/domain/entities/offer_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CategoryEntity> categories;
  final List<DestinationEntity> destinations;
  final List<OfferEntity> offers;
  final int userPoints;

  const HomeLoaded({
    required this.categories,
    required this.destinations,
    required this.offers,
    required this.userPoints,
  });

  @override
  List<Object> get props => [categories, destinations, offers, userPoints];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
