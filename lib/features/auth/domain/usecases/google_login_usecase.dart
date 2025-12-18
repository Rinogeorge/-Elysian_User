import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/auth/domain/entities/user_entity.dart';
import 'package:elysian_user/features/auth/domain/repositories/auth_repository.dart';

class GoogleLoginUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.googleLogin();
  }
}
