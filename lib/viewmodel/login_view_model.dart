import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/data/source/login_result.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends BaseViewModel {
  final BuildContext context;
  AccountRepository _accountRepository;

  LoginViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
  }

  Future<LoginResult> logIn() {
    return _accountRepository.logIn();
  }
}
