import 'package:equatable/equatable.dart';

abstract class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

class LoadBookings extends BookingsEvent {
  const LoadBookings();
}
