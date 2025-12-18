import 'package:elysian_user/features/home/data/models/category_model.dart';
import 'package:elysian_user/features/home/data/models/destination_model.dart';
import 'package:elysian_user/features/home/data/models/offer_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<DestinationModel>> getDestinations();
  Future<List<OfferModel>> getOffers();
  Future<int> getUserPoints();
}
