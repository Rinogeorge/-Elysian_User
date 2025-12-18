import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/features/home/data/datasources/home_remote_datasource.dart';
import 'package:elysian_user/features/home/domain/entities/category_entity.dart';
import 'package:elysian_user/features/home/domain/entities/destination_entity.dart';
import 'package:elysian_user/features/home/domain/entities/offer_entity.dart';
import 'package:elysian_user/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> getDestinations() async {
    try {
      final destinations = await remoteDataSource.getDestinations();
      return Right(destinations);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers() async {
    try {
      final offers = await remoteDataSource.getOffers();
      return Right(offers);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUserPoints() async {
    try {
      final points = await remoteDataSource.getUserPoints();
      return Right(points);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
