import 'package:elysian_user/core/usecases/usecase.dart';
import 'package:elysian_user/features/bookings/domain/usecases/get_bookings_usecase.dart';
import 'package:elysian_user/features/bookings/logic/bloc/bookings/bookings_event.dart';
import 'package:elysian_user/features/bookings/logic/bloc/bookings/bookings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final GetBookingsUseCase getBookingsUseCase;

  BookingsBloc({required this.getBookingsUseCase}) : super(BookingsInitial()) {
    on<LoadBookings>(_onLoadBookings);
  }

  Future<void> _onLoadBookings(
    LoadBookings event,
    Emitter<BookingsState> emit,
  ) async {
    emit(BookingsLoading());

    final result = await getBookingsUseCase(NoParams());

    result.fold(
      (failure) => emit(BookingsError(failure.message)),
      (bookings) => emit(BookingsLoaded(bookings: bookings)),
    );
  }
}
