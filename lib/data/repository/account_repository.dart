import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/login_result.dart';

class AccountRepository implements AccountDataSource {
  final AccountDataSource _accountDataSource;
  bool _isLogged = false;

  AccountRepository(this._accountDataSource);

  @override
  Future<LoginResult> logIn() {
    _isLogged = true;
    return _accountDataSource.logIn();
  }

  @override
  bool isLogged() {
    return _isLogged;
  }
}
