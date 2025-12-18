import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String id;
  final String destinationName;
  final String destinationImageUrl;
  final DateTime bookingDate;
  final int numberOfGuests;
  final double totalPrice;
  final String status; // 'confirmed', 'pending', 'cancelled'

  const BookingEntity({
    required this.id,
    required this.destinationName,
    required this.destinationImageUrl,
    required this.bookingDate,
    required this.numberOfGuests,
    required this.totalPrice,
    required this.status,
  });

  @override
  List<Object> get props => [
    id,
    destinationName,
    destinationImageUrl,
    bookingDate,
    numberOfGuests,
    totalPrice,
    status,
  ];
}
