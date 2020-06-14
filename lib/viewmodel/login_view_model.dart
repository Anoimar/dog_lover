import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends BaseViewModel {
  final BuildContext context;
  AccountRepository _accountRepository;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

  LoginViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
  }

  Future<LoginResult> logIn(String email, String password) async {
    _viewState = ViewState.loading;
    return await _accountRepository
        .logIn("vladyslaw@yahoo.com", "qwert54321")
        .whenComplete(() {
      _viewState = ViewState.content;
      notifyListeners();
    });
  }
}
