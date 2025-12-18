import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_event.dart';
import 'package:elysian_user/features/navigation/logic/bloc/bottom_nav/bottom_nav_state.dart';
import 'package:elysian_user/presentation/screens/bookings/bookings_screen.dart';
import 'package:elysian_user/presentation/screens/home/home_screen.dart';
import 'package:elysian_user/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final currentIndex = state is BottomNavInitial ? state.currentIndex : 0;

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [HomeScreen(), BookingsScreen(), ProfileScreen()],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E5BB8),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) {
                  context.read<BottomNavBloc>().add(ChangeTab(index));
                },
                backgroundColor: const Color(0xFF1E5BB8),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration:
                          currentIndex == 0
                              ? BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              )
                              : null,
                      child: const Icon(Icons.home),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration:
                          currentIndex == 1
                              ? BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              )
                              : null,
                      child: const Icon(Icons.calendar_today),
                    ),
                    label: 'Bookings',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration:
                          currentIndex == 2
                              ? BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              )
                              : null,
                      child: const Icon(Icons.person),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
