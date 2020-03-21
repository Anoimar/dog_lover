import 'package:doglover/data/source/account_data_source.dart';

class AccountRepository implements AccountDataSource {
  final AccountDataSource _accountDataSource;

  AccountRepository(this._accountDataSource);

  @override
  Future<bool> isLogged() {
    return _accountDataSource.isLogged();
  }
}
