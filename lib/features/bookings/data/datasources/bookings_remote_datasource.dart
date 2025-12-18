import 'package:elysian_user/features/bookings/data/models/booking_model.dart';

abstract class BookingsRemoteDataSource {
  Future<List<BookingModel>> getBookings();
}
