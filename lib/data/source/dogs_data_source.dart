import 'dart:io';

import 'package:doglover/models/dog.dart';

abstract class DogsDataSource {
  Future<List<Dog>> loadDogs();
  Future<Dog> getDog(String id);
  Future<bool> uploadDogPic(File dogPic, Dog picData);
  Future<bool> deleteDog(int id);
}
