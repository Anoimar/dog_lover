import 'package:doglover/models/breed.dart';
import 'package:floor/floor.dart';

@dao
abstract class FavBreedDao {
  @Query('SELECT * FROM Breed')
  Future<List<Breed>> findAllFav();

  @Query('SELECT * FROM Breed WHERE id = :id')
  Future<Breed> getBreed(int id);

  @insert
  Future<void> insertFav(Breed breed);

  @delete
  Future<void> deleteFav(Breed breed);
}
