import 'package:doglover/data/repository/account_repository.dart';
import 'package:doglover/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateAccountViewModel extends BaseViewModel {
  final BuildContext context;
  AccountRepository _accountRepository;

  CreateAccountViewModel(this.context) {
    _accountRepository = Provider.of<AccountRepository>(context);
  }
}
