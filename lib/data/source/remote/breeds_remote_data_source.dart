import 'package:doglover/api/dog_api_service.dart';
import 'package:doglover/data/source/breeds_data_source.dart';
import 'package:doglover/models/breed.dart';

class BreedsRemoteDataSource implements BreedsDataSource {
  final DogApiService dogApiService;
  BreedsRemoteDataSource(this.dogApiService);

  @override
  Future<List<Breed>> loadBreeds() {
    return dogApiService.getBreeds();
  }

  @override
  Future<String> getBreedUrl(String id) {
    return dogApiService.getBreedImageUrl(id);
  }
}
