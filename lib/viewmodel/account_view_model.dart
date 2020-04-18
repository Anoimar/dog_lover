import 'dart:collection';

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

  String get email => _email;

  String get name => _name;

  List<Dog> _dogs = [];

  UnmodifiableListView<Dog> get dogs {
    return UnmodifiableListView(_dogs);
  }

  DogsRepository _dogsRepository;
  AccountRepository _accountRepository;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

  AccountViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
    _dogsRepository = Provider.of<DogsRepository>(context);
    start();
  }

  Future<void> start() async {
    var account = await _accountRepository.getAccount();
    _name = account.name;
    _email = account.email;
    _dogs = await _dogsRepository.loadDogs();
    notifyListeners();
  }

  void logOff() {
    _accountRepository.logOff();
  }
}
