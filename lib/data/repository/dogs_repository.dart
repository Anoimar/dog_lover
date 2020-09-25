import 'dart:io';

import 'package:doglover/data/source/dogs_data_source.dart';
import 'package:doglover/models/dog.dart';

class DogsRepository implements DogsDataSource {
  final DogsDataSource remoteDogsDataSource;

  DogsRepository(this.remoteDogsDataSource);

  @override
  Future<Dog> getDog(String id) {
    return remoteDogsDataSource.getDog(id);
  }

  @override
  Future<List<Dog>> loadDogs() {
    return remoteDogsDataSource.loadDogs();
  }

  @override
  Future<bool> uploadDogPic(File dogPic, Dog picData) {
    return remoteDogsDataSource.uploadDogPic(dogPic, picData);
  }

  @override
  Future<bool> deleteDog(int id) {
    return remoteDogsDataSource.deleteDog(id);
  }
}
