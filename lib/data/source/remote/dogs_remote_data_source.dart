import 'dart:io';

import 'package:doglover/api/dog_lover_api_service.dart';
import 'package:doglover/data/source/dogs_data_source.dart';
import 'package:doglover/models/dog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DogsRemoteService implements DogsDataSource {
  final DogLoverApiService dogLoverApiService;
  final _auth = FirebaseAuth.instance;

  DogsRemoteService(this.dogLoverApiService);

  @override
  Future<Dog> getDog(String id) {
    return dogLoverApiService.getDogDetails(id);
  }

  @override
  Future<List<Dog>> loadDogs() async {
    final user = await _auth.currentUser();
    return dogLoverApiService.getMyDogs(user.uid);
  }

  @override
  Future<bool> uploadDogPic(File dogPic, Dog picData) async {
    final user = await _auth.currentUser();
    return dogLoverApiService.uploadDogPic(user.uid, dogPic, picData);
  }

  @override
  Future<bool> deleteDog(int id) async {
    final user = await _auth.currentUser();
    return dogLoverApiService.deleteDog(user.uid, id);
  }
}
