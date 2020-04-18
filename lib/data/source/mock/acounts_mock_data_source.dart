import 'dart:io';

import 'package:doglover/data/source/remote/account_remote_data_source.dart';
import 'package:doglover/models/account.dart';

class AccountsMockDataSource extends AccountsRemoteDataSource {
  File userAvatar;

  @override
  Future<Account> getAccount() {
    var account = Account('Markus Grey', 'markgray21@yahoo.com', '');
    return Future.value(account);
  }

  @override
  Future<File> getUserAvatar() {
    if (userAvatar != null) {
      return Future.value(userAvatar);
    }
    return null;
  }

  @override
  void uploadUserAvatar(File userAvatar) {
    this.userAvatar = userAvatar;
  }
}
