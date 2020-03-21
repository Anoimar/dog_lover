import 'package:doglover/data/source/account_data_source.dart';

class AccountsRemoteDataSource implements AccountDataSource {
  AccountsRemoteDataSource();

  @override
  Future<bool> isLogged() {
    return Future.value(false);
  }
}
