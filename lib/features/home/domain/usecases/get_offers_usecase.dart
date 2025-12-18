import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/home/domain/entities/offer_entity.dart';
import 'package:elysian_user/features/home/domain/repositories/home_repository.dart';

class GetOffersUseCase implements UseCase<List<OfferEntity>, NoParams> {
  final HomeRepository repository;

  GetOffersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OfferEntity>>> call(NoParams params) async {
    return await repository.getOffers();
  }
}
