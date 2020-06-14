import 'dart:io';

import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/models/account.dart';

class AccountRepository implements AccountDataSource {
  final AccountDataSource _accountDataSource;
  bool _isLogged = false;

  AccountRepository(this._accountDataSource);

  @override
  Future<LoginResult> logIn(String email, String password) async {
    var result = await _accountDataSource.logIn(email, password);
    if (result == LoginResult.success) {
      _isLogged = true;
    }
    return Future.value(result);
  }

  //TODO remove method after release
  set setLogged(bool value) {
    _isLogged = value;
  }

  @override
  Future<SignUpResult> signUp(String email, String password, String name) {
    return _accountDataSource.signUp(email, password, name);
  }

  @override
  Future<ResetPasswordResult> resetPassword(String email) {
    return _accountDataSource.resetPassword(email);
  }

  @override
  bool isLogged() {
    return _isLogged;
  }

  @override
  void logOff() {
    _isLogged = false;
  }

  @override
  Future<Account> getAccount() {
    return _accountDataSource.getAccount();
  }

  @override
  Future<bool> uploadUserAvatar(File userAvatar) {
    return _accountDataSource.uploadUserAvatar(userAvatar);
  }

  @override
  Future<File> getUserAvatar() {
    return _accountDataSource.getUserAvatar();
  }
}
