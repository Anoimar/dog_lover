import 'package:doglover/models/dog.dart';

abstract class DogsDataSource {
  Future<List<Dog>> loadDogs();
  Future<Dog> getDog(String id);
}
