import 'package:doglover/api/app_database.dart';
import 'package:doglover/data/source/favourite_data_source.dart';
import 'package:doglover/models/breed.dart';

class FavouriteLocalDataSource implements FavouriteDataSource {
  @override
  Future<bool> isFavourite(int id) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    var breed = await database.favBreedDao.getBreed(id);
    return breed != null;
  }

  @override
  Future<void> setFavourite(bool isFavourite, Breed breed) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    isFavourite
        ? database.favBreedDao.insertFav(breed)
        : database.favBreedDao.deleteFav(breed);
  }

  @override
  Future<List<Breed>> getFavourite() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.favBreedDao.findAllFav();
  }
}
