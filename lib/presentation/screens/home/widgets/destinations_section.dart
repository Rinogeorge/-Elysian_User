import 'package:elysian_user/features/home/domain/entities/destination_entity.dart';
import 'package:elysian_user/presentation/screens/home/widgets/destination_card.dart';
import 'package:flutter/material.dart';

class DestinationsSection extends StatelessWidget {
  final List<DestinationEntity> destinations;

  const DestinationsSection({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Destinations !',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 340,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: destinations.length + 1,
            itemBuilder: (context, index) {
              if (index == destinations.length) {
                // Scroll indicator
                return Container(
                  width: 60,
                  margin: const EdgeInsets.only(left: 8),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                );
              }
              return DestinationCard(
                destination: destinations[index],
                onTap: () {
                  // Handle destination tap
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
