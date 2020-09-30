import 'dart:io';

import 'package:doglover/data/source/dogs_data_source.dart';
import 'package:doglover/models/dog.dart';

class DogsRepository implements DogsDataSource {
  final DogsDataSource remoteDogsDataSource;
  List<Dog> _dogs = List();

  DogsRepository(this.remoteDogsDataSource);

  @override
  Future<Dog> getDog(int id) {
    var dog = _dogs.firstWhere((dog) => dog.id == id, orElse: () {
      return null;
    });
    if (dog != null) {
      return Future.value(dog);
    }
    return remoteDogsDataSource.getDog(id);
  }

  @override
  Future<List<Dog>> loadMyDogs() async {
    _dogs = await remoteDogsDataSource.loadMyDogs();
    return Future.value(_dogs);
  }

  @override
  Future<List<Dog>> loadOtherDogs() async {
    _dogs = await remoteDogsDataSource.loadOtherDogs();
    return Future.value(_dogs);
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
