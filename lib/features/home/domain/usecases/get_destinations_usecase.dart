import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/home/domain/entities/destination_entity.dart';
import 'package:elysian_user/features/home/domain/repositories/home_repository.dart';

class GetDestinationsUseCase
    implements UseCase<List<DestinationEntity>, NoParams> {
  final HomeRepository repository;

  GetDestinationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DestinationEntity>>> call(NoParams params) async {
    return await repository.getDestinations();
  }
}
