import 'package:doglover/data/repository/dogs_repository.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDogPicViewModel extends BaseViewModel {
  final BuildContext context;
  DogsRepository _dogRepository;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

  EditDogPicViewModel(this.context) {
    _dogRepository = Provider.of<DogsRepository>(context);
  }

  Future<bool> update(int id, String name, String breed, String description) {
    _viewState = ViewState.loading;
    return _dogRepository
        .updateDog(Dog.prepareUpdatePicData(id, name, breed, description))
        .whenComplete(() {
      _viewState = ViewState.content;
      notifyListeners();
    });
  }
}
