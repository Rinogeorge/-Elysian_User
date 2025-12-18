import 'package:elysian_user/features/home/data/datasources/home_remote_datasource.dart';
import 'package:elysian_user/features/home/data/models/category_model.dart';
import 'package:elysian_user/features/home/data/models/destination_model.dart';
import 'package:elysian_user/features/home/data/models/offer_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      CategoryModel(id: '1', name: 'Group', iconName: 'group'),
      CategoryModel(id: '2', name: 'Honeymoon', iconName: 'honeymoon'),
      CategoryModel(id: '3', name: 'Solo', iconName: 'solo'),
      CategoryModel(id: '4', name: 'Mountain', iconName: 'mountain'),
      CategoryModel(id: '5', name: 'Beaches', iconName: 'beaches'),
      CategoryModel(id: '6', name: 'Wild', iconName: 'wild'),
    ];
  }

  @override
  Future<List<DestinationModel>> getDestinations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      DestinationModel(
        id: '1',
        name: 'Andaman',
        imageUrl:
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
        rating: 4.5,
        startingPrice: 50000,
      ),
      DestinationModel(
        id: '2',
        name: 'Kerala',
        imageUrl:
            'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=400',
        rating: 4.5,
        startingPrice: 15000,
      ),
      DestinationModel(
        id: '3',
        name: 'Goa',
        imageUrl:
            'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400',
        rating: 4.7,
        startingPrice: 20000,
      ),
    ];
  }

  @override
  Future<List<OfferModel>> getOffers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      OfferModel(
        id: '1',
        name: 'Europe',
        imageUrl:
            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400',
        rating: 4.5,
        startingPrice: 165000,
      ),
      OfferModel(
        id: '2',
        name: 'Bali',
        imageUrl:
            'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=400',
        rating: 4.8,
        startingPrice: 45000,
      ),
    ];
  }

  @override
  Future<int> getUserPoints() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return 0; // Default points
  }
}
