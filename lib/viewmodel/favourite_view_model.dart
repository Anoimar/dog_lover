import 'dart:collection';

import 'package:doglover/data/repository/favourite_repository.dart';
import 'package:doglover/models/breed.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteViewModel extends BaseViewModel {
  final BuildContext context;
  FavouriteRepository _favouriteRepository;
  List<Breed> _favouriteBreedsList = [];
  ViewState _viewState = ViewState.loading;
  UnmodifiableListView<Breed> get favouriteBreedsList {
    return UnmodifiableListView(_favouriteBreedsList);
  }

  FavouriteViewModel(this.context) {
    _favouriteRepository = Provider.of<FavouriteRepository>(context);
    initialize();
  }

  Future<void> initialize() async {
    notifyListeners();
    _favouriteBreedsList = await _favouriteRepository.getFavourite();
    _viewState = ViewState.content;
    notifyListeners();
  }

  void removeFromFavourite(Breed breed) async {
    _favouriteRepository.setFavourite(false, breed);
    _favouriteBreedsList.remove(breed);
    notifyListeners();
  }
}
