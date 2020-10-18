import 'dart:io';

import 'package:doglover/models/dog.dart';

abstract class DogsDataSource {
  Future<List<Dog>> loadMyDogs();
  Future<List<Dog>> loadOtherDogs();
  Future<Dog> getDog(int id);
  Future<bool> uploadDogPic(File dogPic, Dog picData);
  Future<bool> deleteDog(int id);
  Future<bool> updateDog(Dog picData);
}
