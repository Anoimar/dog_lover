import 'package:doglover/data/source/account_data_source.dart';
import 'package:doglover/data/source/firebase_results.dart';

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

  @override
  Future<SignUpResult> signUp(String email, String password) {
    return _accountDataSource.signUp(email, password);
  }

  @override
  Future<ResetPasswordResult> resetPassword(String email) {
    return _accountDataSource.resetPassword(email);
  }

  @override
  bool isLogged() {
    return _isLogged;
  }
}
