import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final double startingPrice;

  const OfferEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.startingPrice,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, startingPrice];
}
