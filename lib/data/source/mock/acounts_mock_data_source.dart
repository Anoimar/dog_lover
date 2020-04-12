import 'package:doglover/data/source/remote/account_remote_data_source.dart';
import 'package:doglover/models/account.dart';

class AccountsMockDataSource extends AccountsRemoteDataSource {
  @override
  Future<Account> getAccount() {
    var account = Account('Markus Grey', 'markgray21@yahoo.com', '');
    return Future.value(account);
  }
}
