import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountViewModel extends BaseViewModel {
  final BuildContext context;
  AccountRepository _accountRepository;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

  CreateAccountViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
  }

  Future<SignUpResult> signUp(String email, String password) {
    _viewState = ViewState.loading;
    return _accountRepository.signUp(email, password).whenComplete(() {
      _viewState = ViewState.content;
      notifyListeners();
    });
  }
}
