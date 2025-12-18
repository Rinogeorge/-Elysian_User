import 'package:equatable/equatable.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();

  @override
  List<Object> get props => [];
}

class BottomNavInitial extends BottomNavState {
  final int currentIndex;

  const BottomNavInitial({this.currentIndex = 0});

  @override
  List<Object> get props => [currentIndex];
}

