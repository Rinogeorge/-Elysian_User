import 'package:dartz/dartz.dart';
import 'package:elysian_user/core/error/failures.dart';
import 'package:elysian_user/features/bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:elysian_user/features/bookings/domain/entities/booking_entity.dart';
import 'package:elysian_user/features/bookings/domain/repositories/bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final BookingsRemoteDataSource remoteDataSource;

  BookingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() async {
    try {
      final bookings = await remoteDataSource.getBookings();
      return Right(bookings);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
