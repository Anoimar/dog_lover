import 'dart:io';

import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/models/account.dart';
import 'package:doglover/models/account_data.dart';

abstract class AccountDataSource {
  bool isLogged();

  Future<LoginResult> logIn(String email, String password);

  void logOff();

  Future<SignUpResult> signUp(String email, String password, String name);

  Future<ResetPasswordResult> resetPassword(String email);

  Future<Account> getAccount();

  Future<AccountData> getAccountData();

  Future<bool> uploadUserAvatar(File userAvatar);
}
