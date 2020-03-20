import 'dart:collection';

import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchViewModel extends BaseViewModel {
  final BuildContext context;
  BreedsRepository _breedsRepository;
  List<Breed> _filteredBreedsList = [];
  UnmodifiableListView<Breed> get filteredBreedsList {
    return UnmodifiableListView(_filteredBreedsList);
  }

  SearchViewModel({@required this.context}) {
    _breedsRepository = Provider.of<BreedsRepository>(context);
  }

  Future<void> queryResults(String query) async {
    List<Breed> breeds = await _breedsRepository.loadBreeds();
    _filteredBreedsList = breeds.where((breed) {
      List<String> words = breed.name.split(' ');
      for (String word in words) {
        if (word.toLowerCase().startsWith(query.toLowerCase().trim())) {
          return true;
        }
      }
      return false;
    }).toList();
    notifyListeners();
  }

  Future<String> getImageUrl(String id) => _breedsRepository.getBreedUrl(id);
}
