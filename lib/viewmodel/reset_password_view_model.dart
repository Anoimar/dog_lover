import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:doglover/viewmodel/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final BuildContext context;
  AccountRepository _accountRepository;
  ViewState _viewState = ViewState.content;

  ViewState get viewState => _viewState;

  ResetPasswordViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
  }

  Future<ResetPasswordResult> reset(String email) {
    _viewState = ViewState.loading;
    return _accountRepository.resetPassword(email).whenComplete(() {
      _viewState = ViewState.content;
      notifyListeners();
    });
  }
}
