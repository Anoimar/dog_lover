import 'dart:io';

import 'package:doglover/data/source/dogs_data_source.dart';
import 'package:doglover/models/dog.dart';

class DogsMockDataSource implements DogsDataSource {
  List<Dog> dogs = [
    Dog('Grandor', 21,
        picUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR1BvEmiwiqBfPREDHpU40Si5mHdA7nlnk23CEbBRXM8vMMh8Jn&usqp=CAU'),
    Dog('Rex', 22,
        picUrl:
            'https://cdn.pixabay.com/photo/2018/05/09/16/15/dog-3385541_960_720.jpg'),
    Dog('Foxie', 23,
        picUrl:
            'https://cdn.pixabay.com/photo/2017/02/01/09/48/dog-2029214_960_720.jpg'),
    Dog('Nando', 24,
        picUrl:
            'https://cdn.pixabay.com/photo/2016/10/15/12/01/dog-1742295_960_720.jpg'),
  ];

  @override
  Future<List<Dog>> loadMyDogs() {
    return Future.value(dogs);
  }

  @override
  Future<List<Dog>> loadOtherDogs() {
    return Future.value(dogs);
  }

  @override
  Future<Dog> getDog(int id) {
    return Future.value(dogs.firstWhere((dog) {
      return dog.id == id;
    }));
  }

  @override
  Future<bool> uploadDogPic(File dogPic, Dog picData) {
    return Future.value(true);
  }

  @override
  Future<bool> updateDog(Dog picData) {
    return Future.value(true);
  }

  @override
  Future<bool> deleteDog(int id) {
    return Future.value(true);
  }
}
