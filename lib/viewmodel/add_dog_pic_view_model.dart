import 'dart:io';

import 'package:doglover/data/repository/dogs_repository.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDogPicViewModel extends BaseViewModel {
  final BuildContext context;
  DogsRepository _dogRepository;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

  File _dogPic;
  File get dogPic => _dogPic;

  AddDogPicViewModel(this.context) {
    _dogRepository = Provider.of<DogsRepository>(context);
  }

  Future<bool> uploadPic(String name, String breed, String description) {
    print(description);
    _viewState = ViewState.loading;
    return _dogRepository
        .uploadDogPic(_dogPic, Dog.preparePicData(name, breed, description))
        .whenComplete(() {
      _viewState = ViewState.content;
      notifyListeners();
    });
  }

  void imagePicked(File image) {
    _dogPic = image;
    notifyListeners();
  }
}
