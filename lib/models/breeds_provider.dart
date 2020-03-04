import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BreedsProvider with ChangeNotifier {
  Future<String> loadAsset() async {
    return await rootBundle.loadString('secrets/secrets.json');
  }

  BreedsProvider() {
    fetchData();
  }

  String _url = 'https://api.thedogapi.com/v1/breeds';
  String _jsonResponse = '';
  List<Breed> _breedsList = [];

  bool _isFetching = false;
  bool get isFetching => _isFetching;
  List<Breed> get breedsList => _breedsList;

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();
    final apiData = await loadAsset();
    final String key = jsonDecode(apiData)["api_key"];
    Map<String, String> headers = {'X-Api-Key': key};
    var response = await http.get(_url, headers: headers);
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      List<dynamic> dogInfo = jsonDecode(_jsonResponse);
      _breedsList = dogInfo
          .map((data) => Breed(id: data['id'], name: data['name']))
          .toList();
    }
    _isFetching = false;
    notifyListeners();
  }
}

class Breed {
  final int id;
  final String name;

  Breed({this.id, this.name});
}
