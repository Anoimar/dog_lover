import 'dart:collection';

import 'package:doglover/data/repository/breeds_repository.dart';
import 'package:doglover/data/repository/favourite_repository.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SearchViewModel extends BaseViewModel {
  final BuildContext context;
  BreedsRepository _breedsRepository;
  List<Tuple2<bool, Breed>> _filteredBreedsList = [];
  FavouriteRepository _favouriteRepository;
  UnmodifiableListView<Tuple2<bool, Breed>> get filteredBreedsList {
    return UnmodifiableListView(_filteredBreedsList);
  }

  SearchViewModel({@required this.context}) {
    _breedsRepository = Provider.of<BreedsRepository>(context);
    _favouriteRepository = Provider.of<FavouriteRepository>(context);
  }

  Future<void> queryResults(String query) async {
    var favouriteBreeds = await _favouriteRepository.getFavourite();
    var favouriteBreedsId = favouriteBreeds.map((b) => b.id).toList();
    List<Breed> breeds = await _breedsRepository.loadBreeds();
    _filteredBreedsList = breeds
        .where((breed) {
          List<String> words = breed.name.split(' ');
          for (String word in words) {
            if (word.toLowerCase().startsWith(query.toLowerCase().trim())) {
              return true;
            }
          }
          return false;
        })
        .map((breed) => Tuple2(favouriteBreedsId.contains(breed.id), breed))
        .toList();
    notifyListeners();
  }

  Future<String> getImageUrl(String id) => _breedsRepository.getBreedUrl(id);
}
