import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/bookings/domain/entities/booking_entity.dart';
import 'package:elysian_user/features/bookings/domain/repositories/bookings_repository.dart';

class GetBookingsUseCase implements UseCase<List<BookingEntity>, NoParams> {
  final BookingsRepository repository;

  GetBookingsUseCase(this.repository);

  @override
  Future<Either<Failure, List<BookingEntity>>> call(NoParams params) async {
    return await repository.getBookings();
  }
}
