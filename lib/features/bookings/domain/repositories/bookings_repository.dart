import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/features/bookings/domain/entities/booking_entity.dart';

abstract class BookingsRepository {
  Future<Either<Failure, List<BookingEntity>>> getBookings();
}
