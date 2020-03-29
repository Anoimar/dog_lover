import 'package:doglover/data/source/firebase_results.dart';

abstract class AccountDataSource {
  bool isLogged();

  Future<LoginResult> logIn(String email, String password);

  Future<SignUpResult> signUp(String email, String password);
}
