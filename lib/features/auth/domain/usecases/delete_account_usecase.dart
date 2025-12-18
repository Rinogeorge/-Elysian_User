import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteAccount();
  }
}
