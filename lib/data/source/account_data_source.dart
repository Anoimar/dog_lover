import 'package:doglover/data/source/firebase_results.dart';
import 'package:doglover/models/account.dart';

abstract class AccountDataSource {
  bool isLogged();

  Future<LoginResult> logIn(String email, String password);

  Future<SignUpResult> signUp(String email, String password, String name);

  Future<ResetPasswordResult> resetPassword(String email);

  Future<Account> getAccount();
}
