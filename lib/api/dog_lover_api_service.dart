import 'dart:convert';

import 'package:doglover/models/dog.dart';
import 'package:http/http.dart' as http;

class DogLoverApiService {
  String _baseUrl = 'https://doggie-lover.herokuapp.com/';
  String _jsonResponse = '';

  Future<List<Dog>> getMyDogs() async {
    http.Response response = await _makeApiCall('dogs');
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      List<dynamic> dogInfo = jsonDecode(_jsonResponse);
      return dogInfo.map((data) => Dog.fromJson(data)).toList();
    }
    throw Exception();
  }

  Future<Dog> getDogDetails(String id) async {
    http.Response response = await _makeApiCall('dogs');
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      List<dynamic> dogInfo = jsonDecode(_jsonResponse);
      return dogInfo.map((data) => Dog.fromJson(data)).toList().first;
    }
    throw Exception();
  }

  Future<http.Response> _makeApiCall(String endpoint) async {
    var response = await http.get('$_baseUrl$endpoint');
    return response;
  }
}
