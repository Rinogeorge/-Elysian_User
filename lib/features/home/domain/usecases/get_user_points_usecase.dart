import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/home/domain/repositories/home_repository.dart';

class GetUserPointsUseCase implements UseCase<int, NoParams> {
  final HomeRepository repository;

  GetUserPointsUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.getUserPoints();
  }
}
