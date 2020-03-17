import 'package:doglover/models/breed.dart';

abstract class BreedsDataSource {
  Future<List<Breed>> loadBreeds();
  Future<String> getBreedUrl(String id);
}
