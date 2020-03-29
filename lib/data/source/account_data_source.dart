import 'package:doglover/data/source/login_result.dart';

abstract class AccountDataSource {
  bool isLogged();

  Future<LoginResult> logIn(String email, String password);
}
