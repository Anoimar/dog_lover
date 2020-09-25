import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doglover/models/account_data.dart';
import 'package:doglover/models/dog.dart';
import 'package:http/http.dart' as http;

class DogLoverApiService {
  //String _baseUrl = 'https://doggie-lover.herokuapp.com/';
  String _baseUrl = 'http://192.168.1.27:8080/';
  String _jsonResponse = '';

  Future<List<Dog>> getMyDogs(String userId) async {
    Dio dio = new Dio(BaseOptions(baseUrl: _baseUrl));
    var response =
        await dio.get('/my-dogs', queryParameters: {"userId": userId});
    if (response.statusCode == 200) {
      print(response.data);
      List responseBody = response.data;
      return responseBody.map((dog) => Dog.fromJson(dog)).toList();
    }
    throw Exception();
  }

  Future<bool> deleteDog(String userId, int dogId) async {
    Dio dio = new Dio(BaseOptions(baseUrl: _baseUrl));
    var response = await dio.get('/my-dogs-delete',
        queryParameters: {"userId": userId, "dogId": dogId});
    if (response.statusCode == 200) {
      return response.data;
    }
    return false;
  }

  Future<Dog> getDogDetails(String id) async {
    http.Response response = await _makeGetApiCall('dogs');
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      List<dynamic> dogInfo = jsonDecode(_jsonResponse);
      return dogInfo.map((data) => Dog.fromJson(data)).toList().first;
    }
    throw Exception();
  }

  Future<bool> uploadAvatar(String uploaderId, File avatarImage) async {
    String fileName = avatarImage.path.split('/').last;
    FormData formData = FormData.fromMap({
      'uploaded_file':
          await MultipartFile.fromFile(avatarImage.path, filename: fileName),
      'uploader': uploaderId
    });
    return uploadPic(formData, fileName, "upload-avatar");
  }

  Future<bool> uploadDogPic(String uploaderId, File dogImage, Dog dog) async {
    String fileName = dogImage.path.split('/').last;
    FormData formData = FormData.fromMap({
      'uploaded_file':
          await MultipartFile.fromFile(dogImage.path, filename: fileName),
      'uploader': uploaderId,
      Dog.keyName: dog.name,
      Dog.keyDescription: dog.description,
      Dog.keyBreed: dog.breed,
    });
    return uploadPic(formData, fileName, "upload-dog");
  }

  Future<bool> uploadPic(
      FormData formData, String fileName, String endpoint) async {
    var response = await Dio().post('$_baseUrl/$endpoint', data: formData);
    if (response.statusCode == 200) {
      return response.data;
    }
    return false;
  }

  Future<AccountData> getUserData(String userId) async {
    Dio dio = new Dio(BaseOptions(baseUrl: _baseUrl));
    var response = await dio.get("/user", queryParameters: {"userId": userId});
    if (response.statusCode == 200) {
      return AccountData.fromJson(response.data);
    }
    throw Exception();
  }

  Future<http.Response> _makeGetApiCall(String endpoint) async {
    var response = await http.get('$_baseUrl$endpoint');
    return response;
  }
}
