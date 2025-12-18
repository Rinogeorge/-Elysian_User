import 'package:elysian_user/features/bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:elysian_user/features/bookings/data/models/booking_model.dart';

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  @override
  Future<List<BookingModel>> getBookings() async {
    // TODO: Implement actual API call
    // For now, return empty list
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }
}
