import 'package:elysian_user/features/bookings/domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.destinationName,
    required super.destinationImageUrl,
    required super.bookingDate,
    required super.numberOfGuests,
    required super.totalPrice,
    required super.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      destinationName: json['destinationName'] as String,
      destinationImageUrl: json['destinationImageUrl'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      numberOfGuests: json['numberOfGuests'] as int,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destinationName': destinationName,
      'destinationImageUrl': destinationImageUrl,
      'bookingDate': bookingDate.toIso8601String(),
      'numberOfGuests': numberOfGuests,
      'totalPrice': totalPrice,
      'status': status,
    };
  }
}
