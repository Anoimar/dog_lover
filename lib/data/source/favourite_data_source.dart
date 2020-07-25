import 'package:doglover/models/breed.dart';

abstract class FavouriteDataSource {
  Future<bool> isFavourite(int id);
  Future<void> setFavourite(bool isFavourite, Breed breed);
  Future<List<Breed>> getFavourite();
}
