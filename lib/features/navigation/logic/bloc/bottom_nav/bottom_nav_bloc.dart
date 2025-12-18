import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial(currentIndex: 0)) {
    on<ChangeTab>(_onChangeTab);
  }

  void _onChangeTab(ChangeTab event, Emitter<BottomNavState> emit) {
    emit(BottomNavInitial(currentIndex: event.index));
  }
}
