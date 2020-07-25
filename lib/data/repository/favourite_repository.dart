import 'package:doglover/data/source/favourite_data_source.dart';
import 'package:doglover/models/breed.dart';

class FavouriteRepository implements FavouriteDataSource {
  final FavouriteDataSource localFavouriteDataSource;

  FavouriteRepository(this.localFavouriteDataSource);

  @override
  Future<bool> isFavourite(int id) {
    return localFavouriteDataSource.isFavourite(id);
  }

  @override
  Future<void> setFavourite(bool isFavourite, Breed breed) {
    return localFavouriteDataSource.setFavourite(isFavourite, breed);
  }

  @override
  Future<List<Breed>> getFavourite() {
    return localFavouriteDataSource.getFavourite();
  }
}
