import 'package:elysian_user/features/home/logic/bloc/home/home_bloc.dart';
import 'package:elysian_user/features/home/logic/bloc/home/home_event.dart';
import 'package:elysian_user/features/home/logic/bloc/home/home_state.dart';
import 'package:elysian_user/presentation/screens/home/widgets/categories_section.dart';
import 'package:elysian_user/presentation/screens/home/widgets/destinations_section.dart';
import 'package:elysian_user/presentation/screens/home/widgets/home_header.dart';
import 'package:elysian_user/presentation/screens/home/widgets/offers_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // Load data if in initial state
            if (state is HomeInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<HomeBloc>().add(const LoadHomeData());
              });
            }

            if (state is HomeInitial || state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(const LoadHomeData());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(points: state.userPoints),
                    CategoriesSection(categories: state.categories),
                    DestinationsSection(destinations: state.destinations),
                    OffersSection(offers: state.offers),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
