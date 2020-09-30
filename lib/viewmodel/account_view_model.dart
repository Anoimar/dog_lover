import 'dart:collection';
import 'dart:io';

import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/data/repository/dogs_repository.dart';
import 'package:doglover/models/dog.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountViewModel extends BaseViewModel {
  final BuildContext context;
  String _name = '';
  String _email = '';
  String _userImageUrl = '';

  String get email => _email;
  String get name => _name;
  String get userImageUrl => _userImageUrl;
  bool _isMyDogsMode = true;
  bool get isMyDogsMode => _isMyDogsMode;
  ViewState _viewState = ViewState.content;
  ViewState get viewState => _viewState;

  List<Dog> _dogs = [];

  UnmodifiableListView<Dog> get dogs {
    return UnmodifiableListView(_dogs);
  }

  DogsRepository _dogsRepository;
  AccountRepository _accountRepository;

  AccountViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
    _dogsRepository = Provider.of<DogsRepository>(context);
    start();
  }

  bool _showMyDogs = true;

  get myDogsSelected => _showMyDogs;

  Future<void> start() async {
    var account = await _accountRepository.getAccount();
    _name = account.name;
    _email = account.email;
    try {
      _dogs = await _dogsRepository.loadMyDogs();
    } catch (e) {
      _viewState = ViewState.error;
    }
    notifyListeners();
    getAccountData();
  }

  Future<void> imagePicked(File newImage) async {
    var result = await _accountRepository.uploadUserAvatar(newImage);
    if (result) {
      getAccountData();
    }
  }

  void logOff() {
    _accountRepository.logOff();
  }

  Future<void> refreshDogsList() async {
    try {
      _dogs = _isMyDogsMode
          ? await _dogsRepository.loadMyDogs()
          : _dogsRepository.loadOtherDogs();
      _viewState = ViewState.content;
    } catch (e) {
      _viewState = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> getAccountData() async {
    var accountData = await _accountRepository.getAccountData();
    _userImageUrl = accountData.avatarUrl;
    notifyListeners();
  }

  Future<void> addNewPic(
      File image, String name, String breed, String description) async {
    var result = await _dogsRepository.uploadDogPic(
      image,
      Dog.preparePicData(name, breed, description),
    );
    if (result) {
      refreshDogsList();
    }
  }

  Future<void> deleteDogPic(int id) async {
    var result = await _dogsRepository.deleteDog(id);
    if (result) {
      refreshDogsList();
    }
  }

  void myDogsToggled(bool isMyDogsMode) {
    _isMyDogsMode = isMyDogsMode;
    refreshDogsList();
    notifyListeners();
  }
}
