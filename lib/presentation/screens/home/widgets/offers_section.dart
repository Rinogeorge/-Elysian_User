import 'package:elysian_user/features/home/domain/entities/offer_entity.dart';
import 'package:elysian_user/presentation/screens/home/widgets/offer_card.dart';
import 'package:flutter/material.dart';

class OffersSection extends StatelessWidget {
  final List<OfferEntity> offers;

  const OffersSection({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Best offers !',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return OfferCard(
              offer: offers[index],
              onTap: () {
                // Handle offer tap
              },
            );
          },
        ),
      ],
    );
  }
}
