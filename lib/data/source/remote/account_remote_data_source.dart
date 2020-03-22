import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/login_result.dart';

class AccountsRemoteDataSource implements AccountDataSource {
  AccountsRemoteDataSource();

  @override
  bool isLogged() {
    throw ('Not implemented in remote');
  }

  @override
  Future<LoginResult> logIn() {
    return Future.value(LoginResult.success);
  }
}
