import 'dart:io';

import 'package:doglover/api/dog_lover_api_service.dart';
import 'package:doglover/data/source/remote/account_remote_data_source.dart';
import 'package:doglover/models/account.dart';
import 'package:doglover/models/account_data.dart';

class AccountsMockDataSource extends AccountsRemoteDataSource {
  AccountData accountData;
  File userAvatar;

  AccountsMockDataSource(DogLoverApiService dogLoverApiService)
      : super(dogLoverApiService);

  @override
  Future<Account> getAccount() {
    var account = Account('Markus Grey', 'markgray21@yahoo.com', '');
    return Future.value(account);
  }

  @override
  Future<AccountData> getAccountData() {
    if (accountData != null) {
      return Future.value(accountData);
    }
    return null;
  }

  @override
  Future<bool> uploadUserAvatar(File userAvatar) async {
    this.userAvatar = userAvatar;
  }
}
