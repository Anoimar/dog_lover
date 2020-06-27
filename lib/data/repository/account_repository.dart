import 'dart:io';

import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/models/account.dart';
import 'package:doglover/models/account_data.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AccountRepository implements AccountDataSource {
  final AccountDataSource _accountDataSource;
  bool _isLogged = false;
  bool _cacheIsDirty = false;
  AccountData _accountData;
  String _avatarUrl = '';

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
  Future<bool> uploadUserAvatar(File userAvatar) async {
    var result = await _accountDataSource.uploadUserAvatar(userAvatar);
    if (result) {
      await DefaultCacheManager().removeFile(_avatarUrl);
      _avatarUrl = '';
    }
    return Future.value(result);
  }

  @override
  Future<AccountData> getAccountData() async {
    if (_cacheIsDirty || _accountData == null) {
      _accountData = await _accountDataSource.getAccountData();
    }
    if (_avatarUrl == '') {
      _avatarUrl = _accountData.avatarUrl +
          '?v=${DateTime.now().millisecondsSinceEpoch}';
      _accountData.avatarUrl = _avatarUrl;
    }
    return Future.value(_accountData);
  }
}
