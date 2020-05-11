import 'package:doglover/api/dog_lover_api_service.dart';
import 'package:doglover/data/source/dogs_data_source.dart';
import 'package:doglover/models/dog.dart';

class DogsRemoteService implements DogsDataSource {
  final DogLoverApiService dogLoverApiService;

  DogsRemoteService(this.dogLoverApiService);

  @override
  Future<Dog> getDog(String id) {
    return dogLoverApiService.getDogDetails(id);
  }

  @override
  Future<List<Dog>> loadDogs() {
    return dogLoverApiService.getMyDogs();
  }
}
