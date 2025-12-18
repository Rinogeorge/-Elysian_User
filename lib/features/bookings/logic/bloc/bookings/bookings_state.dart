import 'package:elysian_user/features/bookings/domain/entities/booking_entity.dart';
import 'package:equatable/equatable.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();

  @override
  List<Object> get props => [];
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  final List<BookingEntity> bookings;

  const BookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

class BookingsError extends BookingsState {
  final String message;

  const BookingsError(this.message);

  @override
  List<Object> get props => [message];
}
