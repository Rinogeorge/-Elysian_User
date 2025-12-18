import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/features/home/domain/entities/category_entity.dart';
import 'package:elysian_user/features/home/domain/entities/destination_entity.dart';
import 'package:elysian_user/features/home/domain/entities/offer_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, List<DestinationEntity>>> getDestinations();
  Future<Either<Failure, List<OfferEntity>>> getOffers();
  Future<Either<Failure, int>> getUserPoints();
}
